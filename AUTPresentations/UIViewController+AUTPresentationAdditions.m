//
//  UIViewController+AUTPresentationAdditions.m
//  AUTPresentations
//
//  Created by Robert Böhnke on 23/04/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import AUTExtReactiveCocoa;

#import "AUTExtObjC.h"

#import "UIViewController+AUTPresentationAdditions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIViewController (AUTPresentationAdditions)

- (RACSignal *)aut_presentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        [self presentViewController:viewController animated:animated completion:^{
            [subscriber sendCompleted];
        }];

        return (RACDisposable *)nil;
    }] setNameWithFormat:@"%@ -aut_presentViewController: %@ animated: %i", self, viewController, (int)animated];
}

- (RACSignal *)aut_dismissViewControllerAnimated:(BOOL)animated {
    @weakify(self);
    
    return [[RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        @strongifyOr(self) {
            [subscriber sendCompleted];
            return nil;
        }

        // If self is not a presented view controller and self is not presenting
        // another view controller, complete immediately, since dismissal will
        // have no effect.
        if (self.presentedViewController == nil && self.presentingViewController == nil) {
            [subscriber sendCompleted];
            return nil;
        }
        
        // In the case where we are attempting to dismiss the same view
        // controller twice -dismissViewControllerAnimated:completion: is never
        // called.
        //
        // In order to guarantee that our signal completes we need to watch the
        // view controller dismissing as well.
        let didDismissDisposable = [[[self aut_didDismiss]
            ignoreValues]
            subscribe:subscriber];

        let completion = ^{
            [subscriber sendCompleted];
        };

        // If we're in the middle of a stack, invoke dismissViewController: on
        // the presentingViewController, otherwise we will just dismiss the view
        // controller we're presenting, but remain presented ourselves.
        if (self.presentedViewController != nil && self.presentingViewController != nil) {
            [self.presentingViewController dismissViewControllerAnimated:animated completion:completion];
        } else {
            [self dismissViewControllerAnimated:animated completion:completion];
        }

        return didDismissDisposable;
    }] setNameWithFormat:@"%@ -aut_dismissViewControllerAnimated: %i", self, (int)animated];
}

- (RACSignal *)aut_didDismiss {
    @weakify(self);

    // A view controller can be considered "dismissed" when viewDidDisappear is
    // invoked and isBeingDismissed is true.
    return [[[self aut_viewDidDisappear]
        filter:^ BOOL (id _) {
            // If the view controller has been deallocated, it has definitely
            // been dismissed.
            @strongifyOr(self) return YES;

            // This also works for stacks of presented view controllers. If you
            // have a presentation stack of A -> B -> C, when A calls
            // dismissViewControllerAnimated: UIKit defensively invokes
            // viewDidDisappear on both B and C during dismissal.
            return [self isBeingDismissed];
        }]
        mapReplace:RACUnit.defaultUnit];
}

@end

NS_ASSUME_NONNULL_END
