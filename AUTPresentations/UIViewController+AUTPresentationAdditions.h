//
//  UIViewController+AUTPresentationAdditions.h
//  AUTPresentations
//
//  Created by Robert Böhnke on 23/04/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AUTPresentationAdditions)

/// Completes when the provided view controller is presented.
- (RACSignal *)aut_presentViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// Completes when the presented view controller is dismissed.
- (RACSignal *)aut_dismissViewControllerAnimated:(BOOL)animated;

/// Sends a value when the receiver is dismissed.
- (RACSignal<RACUnit *> *)aut_didDismiss;

@end

NS_ASSUME_NONNULL_END
