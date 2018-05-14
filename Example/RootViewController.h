//
//  RootViewController.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;
@import AUTPresentations;

@class RootViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithViewModel:(RootViewModel *)viewModel NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic) RootViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
