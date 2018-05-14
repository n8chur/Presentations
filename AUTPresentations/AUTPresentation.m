//
//  AUTPresentation.m
//  AUTPresentations
//
//  Created by James Lawton on 1/20/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;

#import "AUTPresentation.h"
#import "AUTExtObjC.h"

NS_ASSUME_NONNULL_BEGIN

static let AUTPresentationDeallocated = @"AUTPresentationDeallocated";

/// If the argument is an NSNumber, returns its bool value. If not, returns YES
/// as a fallback.
static BOOL AUTAnimatedFallback(id animated) {
    return ([animated isKindOfClass:NSNumber.class]) ? [animated boolValue] : YES;
}

@implementation AUTPresentation

@synthesize present = _present;
@synthesize viewController = _viewController;

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithPresentedViewController:(UIViewController *)viewController present:(AUTPresentBlock)present {
    AUTAssertNotNil(viewController, present);

    present = [present copy];

    self = [super init];

    _viewController = viewController;

    let viewControllerName = [viewController description];

    @weakify(self);
    _present = [RACCommand aut_oneShotCommandWithSignalBlock:^(id input) {
        @strongifyOr(self) {
            let reason = [NSString stringWithFormat:@"The presentation of %@ was deallocated before the call to presentCommand.", viewControllerName];
            @throw [NSException exceptionWithName:AUTPresentationDeallocated reason:reason userInfo:nil];
        }
        return present(self.viewController, AUTAnimatedFallback(input));
    }];

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, @{
        @keypath(self, viewController): self.viewController,
    }];
}

@end

@interface AUTDismissiblePresentation () {
    RACSubject<NSNumber *> *_presented;
}
@end

@implementation AUTDismissiblePresentation

@synthesize present = _present;
@synthesize presented = _presented;
@synthesize dismiss = _dismiss;
@synthesize didDismiss = _didDismiss;
@synthesize viewController = _viewController;

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithPresentedViewController:(UIViewController *)viewController present:(AUTPresentBlock)present dismiss:(AUTDismissBlock)dismiss didDismiss:(nullable RACSignal *)didDismiss {
    AUTAssertNotNil(viewController, present, dismiss);

    present = [present copy];
    dismiss = [dismiss copy];

    self = [super init];

    _viewController = viewController;

    // Sends NO immediately, YES once presentation has occurred, and then NO
    // once dismissed.
    _presented = [RACReplaySubject replaySubjectWithCapacity:1];

    // Sends NO once presentation occurs.
    let canPresent = [[[_presented not] ignore:@YES] take:1];

    @weakify(self);

    _present = [[RACCommand alloc] initWithEnabled:canPresent signalBlock:^(id input) {
        @strongifyOr(self) {
            @throw [NSException exceptionWithName:AUTPresentationDeallocated reason:@"The presentation was deallocated before the call to presentCommand." userInfo:nil];
        }
        return present(self.viewController, AUTAnimatedFallback(input));
    }];

    _dismiss = [[RACCommand alloc] initWithEnabled:_presented signalBlock:^(id input) {
        @strongifyOr(self) {
            @throw [NSException exceptionWithName:AUTPresentationDeallocated reason:@"The presentation was deallocated before the call to dismissCommand." userInfo:nil];
        }
        return dismiss(self.viewController, AUTAnimatedFallback(input));
    }];

    _didDismiss = [[[RACSignal
        merge:@[
            [_dismiss.executionSignals mapReplace:@YES],
            [(didDismiss ?: [RACSignal empty]) mapReplace:@YES],
        ]]
        take:1]
        replayLast];

    [[[[RACSignal
        merge:@[
            [_present aut_didExecute],
            [_didDismiss not],
        ]]
        distinctUntilChanged]
        startWith:@NO]
        subscribe:_presented];

    return self;
}

- (RACSignal *)presentUntilDismissalAnimated:(BOOL)animated {
    return [RACSignal concat:@[
        [self.present execute:@(animated)],
        [self.didDismiss ignoreValues],
    ]];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, @{
        @keypath(self, viewController): self.viewController,
    }];
}

@end

@implementation AUTResultPresentation

@synthesize presentUntilResult = _presentUntilResult;

- (instancetype)initWithPresentedViewController:(UIViewController *)viewController present:(AUTPresentBlock)present dismiss:(AUTDismissBlock)dismiss didDismiss:(nullable RACSignal *)didDismiss AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithPresentedViewController:(UIViewController *)viewController present:(AUTPresentBlock)present dismiss:(AUTDismissBlock)dismiss didDismiss:(nullable RACSignal *)didDismiss result:(RACSignal *)result {
    AUTAssertNotNil(viewController, present, dismiss, result);

    self = [super initWithPresentedViewController:viewController present:present dismiss:dismiss didDismiss:didDismiss];

    @weakify(self);
    _presentUntilResult = [[RACCommand alloc] initWithEnabled:self.present.enabled signalBlock:^(RACTwoTuple<NSNumber *, NSNumber *> *tuple) {
        @strongifyOr(self) {
            @throw [NSException exceptionWithName:AUTPresentationDeallocated reason:@"The presentation was deallocated before the call to presentUntilResultCommand." userInfo:nil];
        }
        
        NSNumber * _Nullable presentationAnimated;
        NSNumber * _Nullable dismissalAnimated;
        if (tuple != nil && [tuple isKindOfClass:RACTuple.class]) {
            presentationAnimated = tuple.first;
            dismissalAnimated = tuple.second;
        }

        // If dismiss is invoked mid-execution, complete result without values.
        let resultUnlessDismissed = [[[result
            take:1]
            // An error on result should catch to empty, or dismissal will
            // not be able to occur due to signal exception semantics.
            catchTo:[RACSignal empty]]
            takeUntil:self.dismiss.executionSignals];

        let dismiss = [[self.dismiss aut_deferExecute:dismissalAnimated]
            // If dismissed by another consumer while this command is being
            // executed, do not propagate an error to consumers.
            catchTo:[RACSignal empty]];

        return [RACSignal concat:@[
            [self.present aut_deferExecute:presentationAnimated],
            resultUnlessDismissed,
            dismiss,
        ]];
    }];

    return self;
}

@end

NS_ASSUME_NONNULL_END
