//
//  CatsNavigationController.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

@class CatsNavigationViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface CatsNavigationController : UINavigationController

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithNavigationBarClass:(nullable Class)navigationBarClass toolbarClass:(nullable Class)toolbarClass NS_UNAVAILABLE;
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController NS_UNAVAILABLE;

- (instancetype)initWithViewModel:(CatsNavigationViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter;

@property (readonly, nonatomic) CatsNavigationViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
