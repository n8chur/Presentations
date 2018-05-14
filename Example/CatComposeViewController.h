//
//  CatComposeViewController.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

#import "CatComposeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatComposeViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithViewModel:(CatComposeViewModel *)viewModel NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic) CatComposeViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
