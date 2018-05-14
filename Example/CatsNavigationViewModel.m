//
//  CatsNavigationViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import AUTPresentations;
@import AUTExtReactiveCocoa;

#import "NSURL+AUTRoutes.h"

#import "CatListViewModel.h"
#import "AUTExtObjC.h"
#import "CatDetailViewModel.h"

#import "CatsNavigationViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CatsNavigationViewModel

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    
    _title = @"Cats";
    
    _catListViewModel = [[CatListViewModel alloc] init];
    
    _presentCatDetail = [RACCommand aut_presentCatDetailCommandWithViewModel:self];
    [[[self presentCatDetailWhenCatListSelectsCat:_catListViewModel]
        takeUntil:self.rac_willDeallocSignal]
        subscribeCompleted:^{}];
    
    _presentImage = [RACCommand aut_presentImageCommandWithViewModel:self];
    
    _routes = [[AUTRoutes alloc] init];
    [self configureRoutes:_routes];
    
    return self;
}

#pragma mark - CatsNavigationViewModel

#pragma mark Presentation Signals

- (RACSignal *)presentCatDetailWhenCatListSelectsCat:(CatListViewModel *)viewModel {
    AUTAssertNotNil(viewModel);
    
    @weakify(self);
    
    return [viewModel.select.aut_values doNext:^(Cat *item) {
        @strongifyOr(self) return;
        
        [self.presentCatDetail execute:RACTuplePack(item, @YES)];
    }];
}

#pragma mark Routing

static let CatNameToken = @"cat_name";

- (void)configureRoutes:(AUTRoutes *)routes {
    AUTAssertNotNil(routes);
    
    @weakify(self);
    
    [routes addRoute:@[ AUTRoutePathComponentDetail ] withSingleTokenHandler:^ RACSignal<CatDetailViewModel *> * (NSString *catName, NSURL *_) {
        @strongifyOr(self) return [RACSignal empty];
        
        let cat = [self.catListViewModel catWithName:catName];
        if (cat == nil) return [RACSignal empty];
        
        return [self.presentCatDetail execute:RACTuplePack(cat, @NO)];
    }];
    
    let catIDToken = [NSString stringWithFormat:@":%@", CatNameToken];
    [routes addRoute:@[ AUTRoutePathComponentDetail, catIDToken, AUTRoutePathComponentImage ] withHandler:^ RACSignal<id<AUTRoutable>> * (NSDictionary<NSString *,NSString *> *parameters, NSURL *_) {
        @strongifyOr(self) return [RACSignal empty];
        
        let catName = parameters[CatNameToken];
        if (catName == nil) return [RACSignal empty];
        
        let cat = [self.catListViewModel catWithName:catName];
        if (cat == nil) return [RACSignal empty];
        
        return [[self.presentCatDetail execute:RACTuplePack(cat, @NO)]
            then:^ RACSignal<ImageViewModel *> * {
                @strongifyOr(self) return [RACSignal empty];
                
                return [self.presentImage execute:RACTuplePack(cat.imageName, cat.name, @NO)];
            }];
    }];
    
    [self.catListViewModel.presentCatCompose aut_execute:@NO whenRoutes:_routes handleRoute:@[ AUTRoutePathComponentAdd ]];
}

#pragma mark - CatsNavigationViewModel<TitledViewModel>

@synthesize title = _title;

#pragma mark - CatsNavigationViewModel<CatDetailPresentingViewModel>

@synthesize presentCatDetail = _presentCatDetail;
@synthesize presentImage = _presentImage;

#pragma mark - CatsNavigationViewModel<AUTRoutable>

@synthesize routes = _routes;

@end

NS_ASSUME_NONNULL_END
