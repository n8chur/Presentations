//
//  CatListViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;

#import "NSURL+AUTRoutes.h"

#import "Cat.h"
#import "AUTExtObjC.h"
#import "CatComposeViewModel.h"

#import "CatListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatListViewModel ()

@property (nonatomic, copy) NSArray<Cat *> *cats;

@end

@implementation CatListViewModel

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    
    _title = @"Cats";
    
    _cats = @[
        [Cat catWithImageName:AUTRandomCatImageName() name:@"Simba"],
        [Cat catWithImageName:AUTRandomCatImageName() name:@"Tigger"],
        [Cat catWithImageName:AUTRandomCatImageName() name:@"Shere Khan"],
    ];
    
    _select = [[RACCommand alloc] initWithSignalBlock:^(Cat *item) {
        return [RACSignal return:item];
    }];
    
    _presentCatCompose = [RACCommand aut_presentCatComposeCommandWithViewModel:self];
    
    [[[self addCatWhenComposed]
        takeUntil:self.rac_willDeallocSignal]
        subscribeCompleted:^{}];
    
    return self;
}

#pragma mark - CatListViewModel

#pragma mark Public

- (void)addCat:(Cat *)cat {
    self.cats = [self.cats arrayByAddingObject:cat];
}

- (nullable Cat *)catWithName:(NSString *)name {
    return [self.cats.rac_sequence objectPassingTest:^ BOOL (Cat *cat) {
        return [cat.name caseInsensitiveCompare:name] == NSOrderedSame;
    }];
}

#pragma mark Private

- (RACSignal *)addCatWhenComposed {
    @weakify(self);
    
    return [[self.presentCatCompose.aut_values
        flattenMap:^(CatComposeViewModel *compose){
            return compose.result;
        }]
        doNext:^(Cat *cat){
            @strongifyOr(self) return;

            [self addCat:cat];
        }];
}

#pragma mark - CatListViewModel<TitledViewModel>

@synthesize title = _title;

#pragma mark - CatListViewModel<CatComposePresentingViewModel>

@synthesize presenter = _presenter;
@synthesize presentCatCompose = _presentCatCompose;

@end

NS_ASSUME_NONNULL_END
