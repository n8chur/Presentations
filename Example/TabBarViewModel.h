//
//  TabBarViewModel.h
//  Example
//
//  Created by Westin Newell on 6/23/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTPresentations;
@import AUTRouting;

@class CatsNavigationViewModel;
@class AboutNavigationViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol TabBarViewModelPresenter

- (id<AUTPresentation>)presentCats:(CatsNavigationViewModel *)cats;

- (id<AUTPresentation>)presentAbout:(AboutNavigationViewModel *)about;

@end

@interface TabBarViewModel : NSObject<AUTRoutable>

@property (readonly, nonatomic) CatsNavigationViewModel *cats;

@property (readonly, nonatomic) AboutNavigationViewModel *about;

@property (weak, nonatomic) id<TabBarViewModelPresenter> presenter;

@end

NS_ASSUME_NONNULL_END
