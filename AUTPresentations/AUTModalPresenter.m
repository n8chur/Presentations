//
//  AUTModalPresenter.m
//  AUTPresentations
//
//  Created by James Lawton on 1/21/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;

#import "UIViewController+AUTPresentationAdditions.h"

#import "AUTExtObjC.h"
#import "AUTPresentation.h"

#import "AUTModalPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface AUTModalPresenter ()

@property (nonatomic, readonly, weak) UIViewController *presentingViewController;

/// Contains the presentations for the currently presented stack of view
/// controllers.
///
/// The most recent (topmost) presentation has the highest index.
///
/// Should only be mutated from the main thread.
@property (nonatomic, copy) NSArray<id<AUTDismissiblePresentation>> *presentations;

@end

@implementation AUTModalPresenter

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController {
    AUTAssertNotNil(presentingViewController);

    self = [super init];

    _presentations = @[];
    _presentingViewController = presentingViewController;

    return self;
}

#pragma mark - AUTModalPresenter

#pragma mark Public

- (id<AUTDismissiblePresentation>)presentationForViewController:(UIViewController *)viewController {
    return [self presentationForViewController:viewController dismissingCurrentModalPresentations:NO];
}

- (id<AUTResultPresentation>)presentationForViewController:(UIViewController *)viewController result:(RACSignal *)result {
    return [self presentationForViewController:viewController result:result dismissingCurrentModalPresentations:NO];
}

- (id<AUTResultPresentation>)presentationForViewController:(UIViewController *)viewController result:(RACSignal *)result dismissingCurrentModalPresentations:(BOOL)dismissingCurrentModalPresentations {
    AUTAssertNotNil(viewController, result);

    AUTPresentBlock presentBlock = [self presentBlockDismissingCurrentModalPresentations:dismissingCurrentModalPresentations];
    AUTDismissBlock dismissBlock = [self createDismissBlock];
    let didDismiss = [viewController aut_didDismiss];

    let presentation = [[AUTResultPresentation alloc]
        initWithPresentedViewController:viewController
        present:presentBlock
        dismiss:dismissBlock
        didDismiss:didDismiss
        result:result];

    [self subscribeToPresentation:presentation];

    return presentation;
}

- (id<AUTDismissiblePresentation>)presentationForViewController:(UIViewController *)viewController dismissingCurrentModalPresentations:(BOOL)dismissingCurrentModalPresentations {
    AUTAssertNotNil(viewController);

    AUTPresentBlock presentBlock = [self presentBlockDismissingCurrentModalPresentations:dismissingCurrentModalPresentations];
    AUTDismissBlock dismissBlock = [self createDismissBlock];
    let didDismiss = [viewController aut_didDismiss];

    let presentation = [[AUTDismissiblePresentation alloc]
        initWithPresentedViewController:viewController
        present:presentBlock
        dismiss:dismissBlock
        didDismiss:didDismiss];

    [self subscribeToPresentation:presentation];

    return presentation;
}

- (RACSignal *)dismissAllPresentationsAnimated:(BOOL)animated {
    let presentingViewController = self.presentingViewController;
    if (presentingViewController == nil) return [RACSignal empty];

    return [presentingViewController aut_dismissViewControllerAnimated:animated];
}

#pragma mark Private

/// Creates a block that returns a cold signal representing presentation of a
/// view controller upon its invocation.
///
/// @param shouldDismiss Whether an existing presentation should be dismissed
///        before presentation of the provided view controller occurs.
- (AUTPresentBlock)presentBlockDismissingCurrentModalPresentations:(BOOL)dismissingCurrentModalPresentations {
    @weakify(self);

    return ^(UIViewController *viewController, BOOL animated) {
        @strongifyOr(self) return [RACSignal empty];

        let dismissPrevious = [RACSignal defer:^ RACSignal * {
            NSArray<id<AUTDismissiblePresentation>> *presentations = self.presentations;

            if (presentations.count == 0) return [RACSignal empty];

            // Dismiss back to the root if specified.
            if (dismissingCurrentModalPresentations) {
                return [self dismissAllPresentationsAnimated:animated];
            }

            // Always dismiss an alert if there is one.
            let topPresentation = presentations.lastObject;
            if ([topPresentation.viewController isKindOfClass:UIAlertController.class]) {
                return [topPresentation.dismiss execute:@(animated)];
            }

            return [RACSignal empty];
        }];

        let present = [RACSignal defer:^{
            @strongify(self);
            var presentingController = self.presentingViewController;
            if (presentingController == nil) return [RACSignal empty];

            // Present from the leafmost view controller in the stack.
            while (presentingController.presentedViewController) {
                presentingController = presentingController.presentedViewController;
            }

            return [presentingController aut_presentViewController:viewController animated:animated];
        }];

        return [dismissPrevious concat:present];
    };
}

/// Creates a block that returns a cold signal representing dismissal of the
/// provided view controller upon subscription.
- (AUTDismissBlock)createDismissBlock {
    return ^(UIViewController *presentedViewController, BOOL animated) {
        AUTAssertNotNil(presentedViewController);
        return [presentedViewController aut_dismissViewControllerAnimated:animated];
    };
}

/// Updates presentations array as the provided presentation progresses through
/// its lifecycle.
- (RACDisposable *)subscribeToPresentation:(id<AUTDismissiblePresentation>)presentation {
    AUTAssertNotNil(presentation);

    @weakify(self);

    return [[presentation.presented skip:1] subscribeNext:^(NSNumber *presented) {
        @strongifyOr(self) return;
        NSAssert(NSThread.isMainThread, @"Presentations must occur on the main thread");

        NSArray<id<AUTDismissiblePresentation>> *presentations = self.presentations;

        if (presented.boolValue) {
            self.presentations = [presentations arrayByAddingObject:presentation];
        } else {
            // If a presentation is dismissed, all presentations above it should
            // be considered dismissed as well.
            NSUInteger index = [presentations indexOfObject:presentation];
            if (index != NSNotFound) {
                self.presentations = [presentations subarrayWithRange:NSMakeRange(0, index)];
            }
        }
    }];
}

@end

NS_ASSUME_NONNULL_END
