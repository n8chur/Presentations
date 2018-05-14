//
//  TabBarViewModel.m
//  Example
//
//  Created by Westin Newell on 6/23/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

#import "NSURL+AUTRoutes.h"

#import "AUTExtObjC.h"
#import "TabBarViewModel.h"
#import "CatsNavigationViewModel.h"
#import "AboutNavigationViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TabBarViewModel ()

@property (readonly, nonatomic) RACCommand<id, CatsNavigationViewModel *> *presentCats;

@property (readonly, nonatomic) RACCommand<id, AboutNavigationViewModel *> *presentAbout;

@end

@implementation TabBarViewModel

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    
    _routes = [[AUTRoutes alloc] init];
    [self configureRoutes:_routes];
    
    _cats = [[CatsNavigationViewModel alloc] init];
    _about = [[AboutNavigationViewModel alloc] init];
    
    _presentCats = [self createPresentCats];
    _presentAbout = [self createPresentAbout];
    
    return self;
}

#pragma mark - TabBarViewModel

#pragma mark Presentation

- (RACCommand<id, CatsNavigationViewModel *> *)createPresentCats {
    @weakify(self);
    
    return [RACCommand aut_presentCommandWithExecutionBlock:^ AUTPresentCommandExecutionContext * _Nullable (id _) {
        @strongify(self);
        let presenter = self.presenter;
        if (self == nil || presenter == nil) return nil;
        
        let presentation = [presenter presentCats:self.cats];
        return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:self.cats animated:@NO];
    }];
}

- (RACCommand<id, AboutNavigationViewModel *> *)createPresentAbout {
    @weakify(self);
    
    return [RACCommand aut_presentCommandWithExecutionBlock:^ AUTPresentCommandExecutionContext * _Nullable (id _) {
        @strongify(self);
        let presenter = self.presenter;
        if (self == nil || presenter == nil) return nil;
        
        let presentation = [presenter presentAbout:self.about];
        return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:self.about animated:@NO];
    }];
}

#pragma mark Routing

- (void)configureRoutes:(AUTRoutes *)routes {
    AUTAssertNotNil(routes);
    
    @weakify(self);
    
    [routes addRoute:@[ AUTRoutePathComponentCats ] withHandler:^ RACSignal<id<AUTRoutable>> * (NSDictionary *_1, NSURL *_2) {
        @strongifyOr(self) return [RACSignal empty];
        
        return [self.presentCats execute:nil];
    }];
    
    [routes addRoute:@[ AUTRoutePathComponentAbout ] withHandler:^ RACSignal<id<AUTRoutable>> * (NSDictionary *_1, NSURL *_2) {
        @strongifyOr(self) return [RACSignal empty];
        
        return [self.presentAbout execute:nil];
    }];
}

#pragma mark - RootViewModel<AUTRoutable>

@synthesize routes = _routes;

@end

NS_ASSUME_NONNULL_END
