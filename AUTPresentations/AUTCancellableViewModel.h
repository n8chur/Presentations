//
//  AUTCancellableViewModel.h
//  AUTPresentations
//
//  Created by Eric Horacek on 5/8/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

/// A view model representing an interactive process that can succeed with a
/// result, fail without a result, or be cancelled.
@protocol AUTCancellableViewModel <NSObject>

/// A command that represents cancelling the receiver.
///
/// If the receiver is presented as within an AUTDismissiblePresentation,
/// this command will be invoked if the receiver is dismissed externally.
///
/// Executing this command should cause `result` to complete.
@property (readonly, nonatomic) RACCommand *cancel;

/// A signal that sends a value if successful. If unsuccessful, completes with
/// no value.
///
/// Should complete if `cancel` is executed.
@property (readonly, nonatomic) RACSignal *result;

@end

@interface RACCommand<__contravariant InputType, __covariant ValueType> (AUTCancellableViewModel)

/// Invokes aut_cancelCommandWithResult:signalBlock: with an empty signalBlock.
+ (RACCommand<InputType, ValueType> *)aut_cancelCommandWithResult:(RACSignal *)result;

/// Creates a command that is enabled until it has been executed once or if the
/// provided result signal completes or errors.
+ (RACCommand<InputType, ValueType> *)aut_cancelCommandWithResult:(RACSignal *)result signalBlock:(RACSignal<ValueType> * (^)(InputType _Nullable input))signalBlock;

/// Returns a command wrapping the receiver that becomes disabled if the
/// provided result completes or errors.
- (RACCommand<InputType, ValueType> *)aut_wrappedCancelCommandWithResult:(RACSignal *)result;

@end

NS_ASSUME_NONNULL_END
