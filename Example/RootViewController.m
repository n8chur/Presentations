//
//  RootViewController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTPresentations;

#import "AUTExtObjC.h"
#import "RootViewModel.h"
#import "TabBarController.h"

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RootViewController() <RootViewModelDelegate, RootViewModelPresenter>

@property (readonly, nonatomic) AUTModalPresenter *modalPresenter;

@end

@implementation RootViewController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewModel:(RootViewModel *)viewModel {
    AUTAssertNotNil(viewModel);
    
    self = [super initWithNibName:nil bundle:nil];
    
    _viewModel = viewModel;
    _viewModel.presenter = self;
    _viewModel.delegate = self;
    
    _modalPresenter = [[AUTModalPresenter alloc] initWithPresentingViewController:self];
    
    return self;
}

#pragma mark - RootViewController

#pragma mark Private

- (void)replaceCurrentViewWithTabBar:(TabBarController *)tabBar {
    AUTAssertNotNil(tabBar);
    
    for (UIViewController *child in self.childViewControllers) {
        [child willMoveToParentViewController:nil];
        [child.view removeFromSuperview];
        [child removeFromParentViewController];
    }
    
    tabBar.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addChildViewController:tabBar];
    
    [self.view addSubview:tabBar.view];
    [NSLayoutConstraint activateConstraints:@[
        [tabBar.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [tabBar.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [tabBar.view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [tabBar.view.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
    ]];
    
    [tabBar didMoveToParentViewController:self];
}

#pragma mark - RootViewController<RootViewModelDelegate>

- (RACSignal *)prepareForRouting {
    return [self.modalPresenter dismissAllPresentationsAnimated:NO];
}

#pragma mark - RootViewController<RootViewModelPresenter>

- (id<AUTPresentation>)presentTabBar:(TabBarViewModel *)viewModel {
    @weakify(self);
    
    let viewController = [[TabBarController alloc] initWithViewModel:viewModel modalPresenter:self.modalPresenter];
    
    return [[AUTPresentation alloc] initWithPresentedViewController:viewController present:^(UIViewController *presentedViewController, BOOL animated) {
        @strongifyOr(self) return [RACSignal empty];
        
        [self replaceCurrentViewWithTabBar:viewController];
        
        return [RACSignal empty];
    }];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel.presentTabBar execute:nil];
}

@end

NS_ASSUME_NONNULL_END
