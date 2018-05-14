//
//  CatListViewController.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;
@import AUTPresentations;

@class CatListViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface CatListViewController : UITableViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewStyle)style NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithViewModel:(CatListViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
