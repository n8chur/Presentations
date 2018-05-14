//
//  RACCommand+AUTPresentation.h
//  AUTPresentations
//
//  Created by James Lawton on 1/21/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

@protocol AUTPresentation;
@protocol AUTDismissiblePresentation;
@class AUTPresentCommandExecutionContext<__covariant ViewModelType>;

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand<__contravariant InputType, __covariant ValueType> (AUTPresentation)

/// Returns a present command execution context when given an input item
typedef AUTPresentCommandExecutionContext<ValueType> * _Nullable (^AUTPresentCommandExecutionBlock)(InputType);

/// Creates a command suitable for presenting a view model upon execution.
///
/// If the presentation is dismissible (is a AUTDismissiblePresentation),
/// disabled until the most recent presentation is dismissed.
///
/// If the presentation vends a result (is a AUTResultPresentation),
/// dismisses automatically when it vends a result.
///
/// Its execution signals send the view model returned in the presentation
/// result immediately, and then complete once presentation has completed. Never
/// errors.
+ (instancetype)aut_presentCommandWithExecutionBlock:(AUTPresentCommandExecutionBlock)executionBlock;

@end

/// Represents the dismissible presentation of a view model.
@interface AUTPresentCommandExecutionContext<__covariant ViewModelType> : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Returns an AUTPresentCommandExecutionContext with a `presentationAnimated`
/// that matches the provided `animated` NSNumber and a value of nil for
/// dismissalAnimated.
+ (instancetype)contextWithPresentation:(id<AUTPresentation>)presentation ofViewModel:(nullable ViewModelType)viewModel animated:(nullable NSNumber *)animated;

+ (instancetype)contextWithPresentation:(id<AUTDismissiblePresentation>)presentation ofViewModel:(nullable ViewModelType)viewModel presentationAnimated:(nullable NSNumber *)presentationAnimated dismissalAnimated:(nullable NSNumber *)dismissalAnimated;

@property (nonatomic, readonly) id<AUTPresentation> presentation;
@property (nullable, nonatomic, readonly) ViewModelType viewModel;

@end

NS_ASSUME_NONNULL_END
