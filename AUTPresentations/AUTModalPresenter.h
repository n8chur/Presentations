//
//  AUTModalPresenter.h
//  AUTPresentations
//
//  Created by James Lawton on 1/21/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import UIKit;
@import ReactiveObjC;

@protocol AUTDismissiblePresentation;
@protocol AUTResultPresentation;

NS_ASSUME_NONNULL_BEGIN

/// Responsible for maintaining a single modal presentation at one time.
///
/// If a new presentation is attempted while another presentation is in
/// progress, presentation fails, except in the case that the current
/// presentation is an alert or action sheet.
///
/// This is useful when an notification comes in, and we want to present an alert
/// in response. No alert in the app is important enough to keep that it should
/// stop a new presentation.
@interface AUTModalPresenter : NSObject

/// Does not retain `presentingViewController`
- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (id<AUTDismissiblePresentation>)presentationForViewController:(UIViewController *)viewController;

- (id<AUTDismissiblePresentation>)presentationForViewController:(UIViewController *)viewController dismissingCurrentModalPresentations:(BOOL)dismissingCurrentModalPresentations;

- (id<AUTResultPresentation>)presentationForViewController:(UIViewController *)viewController result:(RACSignal *)result;

/// Creates a model for presenting the provided view controller.
///
/// This model typically wraps and retains the provided view controller, so
/// deferring presentation by retaining a presentation model should be avoided.
- (id<AUTResultPresentation>)presentationForViewController:(UIViewController *)viewController result:(RACSignal *)result dismissingCurrentModalPresentations:(BOOL)dismissingCurrentModalPresentations;

/// Dismisses the current presentations being performed by the receiver (if
/// there are any) and completes.
- (RACSignal *)dismissAllPresentationsAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
