//
//  UINavigationController+AUTPresentation.m
//  AUTPresentations
//
//  Created by James Lawton on 1/28/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import AUTExtReactiveCocoa;

#import "AUTExtObjC.h"
#import "AUTPresentation.h"

#import "UINavigationController+AUTPresentation.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UINavigationController (AUTPresentation)

#pragma mark - Public

- (id<AUTDismissiblePresentation>)aut_presentationForViewController:(UIViewController *)viewController {
    AUTAssertNotNil(viewController);

    // This could also be done with the navigation controller delegate methods, but
    // would require scanning over `viewControllers` each time.
    let didDismiss = [viewController aut_didMoveToNilParent];

    let present = [self createPresentBlock];
    let dismiss = [self createDismissBlock];
    
    let presentation = [[AUTDismissiblePresentation alloc]
        initWithPresentedViewController:viewController
        present:present
        dismiss:dismiss
        didDismiss:didDismiss];

    // Retain the presentation for its lifecycle.
    [[[[presentation.didDismiss aut_retainUntilDisposal:presentation]
        takeUntil:viewController.rac_willDeallocSignal]
        takeUntil:self.rac_willDeallocSignal]
        subscribeCompleted:^{}];

    return presentation;
}

- (id<AUTResultPresentation>)aut_presentationForViewController:(UIViewController *)viewController result:(RACSignal *)result {
    AUTAssertNotNil(result);

    // This could also be done with the navigation controller delegate methods, but
    // would require scanning over `viewControllers` each time.
    let didDismiss = [viewController aut_didMoveToNilParent];

    let present = [self createPresentBlock];
    let dismiss = [self createDismissBlock];

    let presentation = [[AUTResultPresentation alloc]
        initWithPresentedViewController:viewController
        present:present
        dismiss:dismiss
        didDismiss:didDismiss
        result:result];

    // Retain the presentation for its lifecycle.
    [[[[presentation.didDismiss aut_retainUntilDisposal:presentation]
        takeUntil:viewController.rac_willDeallocSignal]
        takeUntil:self.rac_willDeallocSignal]
        subscribeCompleted:^{}];

    return presentation;
}

#pragma mark - Private

- (AUTPresentBlock)createPresentBlock {
    @weakify(self);
    return ^(UIViewController *presentedViewController, BOOL animated) {
        @strongifyOr(self) return [RACSignal empty];

        return [self aut_pushViewController:presentedViewController animated:animated];
    };
}

- (AUTDismissBlock)createDismissBlock {
    @weakify(self);
    return ^(UIViewController *presentedViewController, BOOL animated) {
        @strongifyOr(self) return [RACSignal empty];

        return [self aut_popViewController:presentedViewController animated:animated];
    };
}

@end

NS_ASSUME_NONNULL_END
