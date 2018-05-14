//
//  AUTPresentation.h
//  AUTPresentations
//
//  Created by James Lawton on 1/20/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

/// Invoked to present of an instance of a view controller.
/// The returned signal should have the lifetime of the presentation animation.
typedef RACSignal * _Nonnull (^AUTPresentBlock)(UIViewController *presentedViewController, BOOL animated);

/// Invoked to dismiss of an instance of a view controller.
/// The returned signal should have the lifetime of the dismissal animation.
typedef RACSignal * _Nonnull (^AUTDismissBlock)(UIViewController *presentedViewController, BOOL animated);

/// Represents the presentation of a view controller.
@protocol AUTPresentation <NSObject>

/// When executed with an NSNumber that represents whether the presentation
/// should be animated, presents the represented view controller. If nil or a
/// type that is not an NSNumber is provided, @YES will be used instead.
///
/// This will execute the `present` block passed in the initializer. Disabled
/// after the view controller is first presented. If the execution parameter is
/// an `NSNumber`, it is treated as a boolean indicating whether presentation
/// should be animated.
@property (readonly, nonatomic) RACCommand<NSNumber *, id> *present;

/// The view controller that is presented by the receiver.
@property (nonatomic, readonly) __kindof UIViewController *viewController;

@end

/// Represents the presentation of a view controller that will be dismissed
/// through its `dismiss` command.
///
/// Implemented as protocol inheritance to prevent concrete implementations from
/// having to inherit from one another.
@protocol AUTDismissiblePresentation <AUTPresentation>

/// When executed with an NSNumber that represents whether the disimssal should
/// be animated, dismisses the represented view controller, if that is
/// supported. If nil or a type that is not an NSNumber is provided, @YES will
/// be used instead.
///
/// This will execute the `dismiss` block passed in the initializer. Disabled
/// while the view controller is not presented, or if no `dismiss` block was
/// given to an initializer.
@property (readonly, nonatomic) RACCommand<NSNumber *, id> *dismiss;

/// Sends YES when the receiver dismisses.
@property (readonly, nonatomic) RACSignal<NSNumber *> *didDismiss;

/// Sends YES if the view controller has been presented and not yet dismissed,
/// or NO otherwise. Replays its last value.
@property (readonly, nonatomic) RACSignal<NSNumber *> *presented;

/// Returns a signal that presents the receiver, and then completes once it has
/// been dismissed. Sends no values.
///
/// Errors if the receiver has already been presented.
- (RACSignal *)presentUntilDismissalAnimated:(BOOL)animated;

@end

/// Represents a presentation that either results in a value or fails. Dismisses
/// in either case.
///
/// Implemented as protocol inheritance to prevent concrete implementations from
/// having to inherit from one another.
@protocol AUTResultPresentation <AUTDismissiblePresentation>

/// When exectued with a tuple first element is whether the presentation should
/// be animated and the second is whether the dismissal should be animated, or
/// nil if nil should be used for both animation values, performs the following
/// steps:
///
/// 1. Executes the present command with the provided input.
/// 2. Subscribes to `result`.
/// 3. Executes the dismiss command with the provided input once result
///    completes.
///
/// Consumers that are interested in the result of this presentation should
/// subscribe to this command's execution signal. If successful no result is
/// produced, the execution will complete when the presentation is dismissed
/// through some other means.
@property (nonatomic, readonly) RACCommand<RACTwoTuple<NSNumber *, NSNumber *> *, id> *presentUntilResult;

@end

/// A concrete implementation of AUTPresentation.
///
/// Presentations are single-use objects, and to present a view a second time, a
/// new presentation should be created.
@interface AUTPresentation : NSObject <AUTPresentation>

/// Initialize with a block representing presentation.
- (instancetype)initWithPresentedViewController:(UIViewController *)viewController present:(AUTPresentBlock)present NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

/// A concrete implementation of AUTDismissiblePresentation.
///
/// Presentations are single-use objects, and to present a view a second time, a
/// new presentation should be created.
@interface AUTDismissiblePresentation : NSObject <AUTDismissiblePresentation>

/// Initialize with a blocks representing presentation and dismissal.
- (instancetype)initWithPresentedViewController:(UIViewController *)viewController present:(AUTPresentBlock)present dismiss:(AUTDismissBlock)dismiss didDismiss:(nullable RACSignal *)didDismiss NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

/// A concrete implementation of AUTResultPresentation.
///
/// Presentations are single-use objects, and to present a view a second time, a
/// new presentation should be created.
@interface AUTResultPresentation : AUTDismissiblePresentation <AUTResultPresentation>

- (instancetype)initWithPresentedViewController:(UIViewController *)viewController present:(AUTPresentBlock)present dismiss:(AUTDismissBlock)dismiss didDismiss:(nullable RACSignal *)didDismiss NS_UNAVAILABLE;

/// Initialize with a blocks representing presentation and dismissal.
///
/// @param result A signal that represents the operation that the provided view
///        controller is performing. The presentation is dismissed when the
///        signal either errors or completes.
- (instancetype)initWithPresentedViewController:(UIViewController *)viewController present:(AUTPresentBlock)present dismiss:(AUTDismissBlock)dismiss didDismiss:(nullable RACSignal *)didDismiss result:(RACSignal *)result NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
