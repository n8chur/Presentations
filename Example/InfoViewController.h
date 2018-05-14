//
//  InfoViewController.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTPresentations;
@import UIKit;

#import "InfoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithViewModel:(InfoViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic) InfoViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
