//
//  CatsNavigationViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTPresentations;
@import AUTRouting;

#import "TitledViewModel.h"
#import "CatDetailPresenter.h"

@class CatListViewModel;
@class CatDetailViewModel;
@protocol CatDetailPresenter;

NS_ASSUME_NONNULL_BEGIN

@protocol CatsNavigationPresenter <CatDetailPresenter>

@end

@interface CatsNavigationViewModel : NSObject<TitledViewModel, CatDetailPresentingViewModel, AUTRoutable>

@property (readonly, nonatomic) CatListViewModel *catListViewModel;

@property (weak, nonatomic) id<CatsNavigationPresenter> presenter;

@end

NS_ASSUME_NONNULL_END
