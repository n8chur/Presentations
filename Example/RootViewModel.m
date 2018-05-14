//
//  RootViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;

#import "NSURL+AUTRoutes.h"

#import "AboutNavigationViewModel.h"
#import "CatsNavigationViewModel.h"
#import "AUTExtObjC.h"
#import "TabBarViewModel.h"

#import "RootViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RootViewModel ()

@end

@implementation RootViewModel

- (instancetype)init {
    self = [super init];
    
    _routes = [[AUTRoutes alloc] init];
    [self configureRoutes:_routes];
    
    _router = [[AUTRouter alloc] initWithRootRoutes:_routes];
    
    _presentTabBar = [self createPresentTabBar];
    
    return self;
}

#pragma mark - RootViewModel

#pragma mark Presentation

- (RACCommand<id, TabBarViewModel *> *)createPresentTabBar {
    @weakify(self);
    
    return [RACCommand aut_presentCommandWithExecutionBlock:^ AUTPresentCommandExecutionContext * _Nullable (id _) {
        @strongify(self);
        let presenter = self.presenter;
        if (self == nil || presenter == nil) return nil;
        
        let tabBar = [[TabBarViewModel alloc] init];
        
        let presentation = [presenter presentTabBar:tabBar];
        return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:tabBar animated:@NO];
    }];
}

#pragma mark Routing

- (void)configureRoutes:(AUTRoutes *)routes {
    AUTAssertNotNil(routes);
    
    @weakify(self);
    
    [routes addRoute:@[ AUTRouteURLHost ] withHandler:^ RACSignal<id<AUTRoutable>> * (NSDictionary *_1, NSURL *_2) {
        @strongify(self);
        let delegate = self.delegate;
        if (delegate == nil) return [RACSignal empty];
        
        let prepare = [delegate prepareForRouting];
        
        let tabBarPresentation = [self.presentTabBar aut_deferExecute:nil];
        
        return [prepare concat:tabBarPresentation];
    }];
}

#pragma mark - RootViewModel<AUTRoutable>

@synthesize routes = _routes;

@end

NS_ASSUME_NONNULL_END
