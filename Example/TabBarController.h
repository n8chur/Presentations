//
//  TabBarController.h
//  Example
//
//  Created by Westin Newell on 6/23/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

@class TabBarViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TabBarController : UITabBarController

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithViewModel:(TabBarViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic) TabBarViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
