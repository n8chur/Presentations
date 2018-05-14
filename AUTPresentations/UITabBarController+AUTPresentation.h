//
//  UITabBarController+AUTPresentation.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/16/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

@protocol AUTPresentation;

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarController (AUTPresentation)

/// Returns a presentation suitable for swapping out the selected view
/// controller with the provided view controller.
- (id<AUTPresentation>)aut_presentationForViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
