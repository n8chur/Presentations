//
//  AboutNavigationController.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

@class AboutNavigationViewModel;
@class AUTModalPresenter;

NS_ASSUME_NONNULL_BEGIN

@interface AboutNavigationController : UINavigationController

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithNavigationBarClass:(nullable Class)navigationBarClass toolbarClass:(nullable Class)toolbarClass NS_UNAVAILABLE;
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController NS_UNAVAILABLE;

- (instancetype)initWithViewModel:(AboutNavigationViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic) AboutNavigationViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
