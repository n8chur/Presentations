//
//  UINavigationController+AUTPresentation.h
//  AUTPresentations
//
//  Created by James Lawton on 1/28/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

@protocol AUTDismissiblePresentation;
@protocol AUTResultPresentation;

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (AUTPresentation)

/// Creates a presentation suitable for presenting and dismissing the provided
/// view controller as a push and pop on the receiver's navigation stack,
/// respectively.
- (id<AUTDismissiblePresentation>)aut_presentationForViewController:(UIViewController *)viewController;

/// Creates a presentation suitable for presenting and dismissing the provided
/// view controller as a push and pop on the receiver's navigation stack,
/// respectively, with a signal reprsenting the result of the presented view
/// controller.
- (id<AUTResultPresentation>)aut_presentationForViewController:(UIViewController *)viewController result:(RACSignal *)result;

@end

NS_ASSUME_NONNULL_END
