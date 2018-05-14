//
//  AboutNavigationController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"
#import "InfoViewController.h"
#import "AboutNavigationViewModel.h"

#import "AboutNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AboutNavigationController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNavigationBarClass:(nullable Class)navigationBarClass toolbarClass:(nullable Class)toolbarClass AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewModel:(AboutNavigationViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter {
    AUTAssertNotNil(viewModel, modalPresenter);
    
    let infoViewController = [[InfoViewController alloc] initWithViewModel:viewModel.infoViewModel modalPresenter:modalPresenter];
    self = [super initWithRootViewController:infoViewController];
    
    _viewModel = viewModel;
    
    self.title = viewModel.title;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:viewModel.title image:nil tag:0];
    
    return self;
}

@end

NS_ASSUME_NONNULL_END
