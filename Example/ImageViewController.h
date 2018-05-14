//
//  ImageViewController.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

@class ImageViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithViewModel:(ImageViewModel *)viewModel NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
