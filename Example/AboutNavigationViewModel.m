//
//  AboutNavigationViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "NSURL+AUTRoutes.h"

#import "InfoViewModel.h"

#import "AboutNavigationViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AboutNavigationViewModel

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    
    _title = @"About";
    
    _infoViewModel = [[InfoViewModel alloc] init];
    
    _routes = [[AUTRoutes alloc] init];
    [_infoViewModel.presentFAQ aut_execute:@NO whenRoutes:_routes handleRoute:@[ AUTRoutePathComponentFAQ ]];
    
    return self;
}

#pragma mark - AboutNavigationViewModel<TitledViewModel>

@synthesize title = _title;

#pragma mark - AboutNavigationViewModel<AUTRoutable>

@synthesize routes = _routes;

@end

NS_ASSUME_NONNULL_END
