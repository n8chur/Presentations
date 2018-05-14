//
//  CatListViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

#import "TitledViewModel.h"
#import "CatComposePresenter.h"

@class Cat;

NS_ASSUME_NONNULL_BEGIN

@interface CatListViewModel : NSObject<TitledViewModel, CatComposePresentingViewModel>

/// This property is key-value-observable.
@property (readonly, nonatomic, copy) NSArray<Cat *> *cats;

@property (readonly, nonatomic) RACCommand<Cat *, Cat *> *select;

- (void)addCat:(Cat *)cat;

- (nullable Cat *)catWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
