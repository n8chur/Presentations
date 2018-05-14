//
//  TabBarController.m
//  Example
//
//  Created by Westin Newell on 6/23/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTPresentations;

#import "AUTExtObjC.h"
#import "TabBarViewModel.h"
#import "AboutNavigationController.h"
#import "CatsNavigationController.h"

#import "TabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TabBarController () <TabBarViewModelPresenter>

@property (readonly, nonatomic) CatsNavigationController *cats;
@property (readonly, nonatomic) AboutNavigationController *about;

@end

@implementation TabBarController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewModel:(TabBarViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter {
    AUTAssertNotNil(viewModel, modalPresenter);
    
    self = [super initWithNibName:nil bundle:nil];
    
    _viewModel = viewModel;
    _viewModel.presenter = self;
    
    _cats = [[CatsNavigationController alloc] initWithViewModel:_viewModel.cats modalPresenter:modalPresenter];
    _about = [[AboutNavigationController alloc] initWithViewModel:_viewModel.about modalPresenter:modalPresenter];
    
    self.viewControllers = @[ _cats, _about ];
    
    return self;
}

#pragma mark - TabBarController<TabBarViewModelPresenter>

- (id<AUTPresentation>)presentCats:(CatsNavigationViewModel *)cats {
    return [self aut_presentationForViewController:self.cats];
}

- (id<AUTPresentation>)presentAbout:(AboutNavigationViewModel *)about {
    return [self aut_presentationForViewController:self.about];
}

@end

NS_ASSUME_NONNULL_END
