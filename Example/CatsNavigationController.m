//
//  CatsNavigationController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "CatsNavigationViewModel.h"
#import "AUTExtObjC.h"
#import "CatListViewController.h"
#import "CatDetailViewController.h"
#import "ImageViewController.h"

#import "CatsNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatsNavigationController () <CatsNavigationPresenter>

@end

@implementation CatsNavigationController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNavigationBarClass:(nullable Class)navigationBarClass toolbarClass:(nullable Class)toolbarClass AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewModel:(CatsNavigationViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter {
    AUTAssertNotNil(viewModel, modalPresenter);
    
    let catListViewController = [[CatListViewController alloc] initWithViewModel:viewModel.catListViewModel modalPresenter:modalPresenter];
    self = [super initWithRootViewController:catListViewController];
    
    _viewModel = viewModel;
    _viewModel.presenter = self;
    
    self.title = viewModel.title;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:viewModel.title image:nil tag:0];
    
    return self;
}

#pragma mark - CatsNavigationController<CatsNavigationPresenter>

- (id<AUTDismissiblePresentation>)presentCatDetail:(CatDetailViewModel *)detail {
    let viewController = [[CatDetailViewController alloc] initWithDetailViewModel:detail];
    return [self aut_presentationForViewController:viewController];
}

- (id<AUTDismissiblePresentation>)presentImageViewModel:(ImageViewModel *)imageViewModel {
    let viewController = [[ImageViewController alloc] initWithViewModel:imageViewModel];
    return [self aut_presentationForViewController:viewController];
}

@end

NS_ASSUME_NONNULL_END
