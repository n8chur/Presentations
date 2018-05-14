//
//  FAQViewController.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

#import "FAQViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithFAQViewModel:(FAQViewModel *)viewModel NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic) FAQViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
