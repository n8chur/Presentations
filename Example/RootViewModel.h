//
//  RootViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTRouting;
@import AUTPresentations;

@class TabBarViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol RootViewModelPresenter

- (id<AUTPresentation>)presentTabBar:(TabBarViewModel *)viewModel;

@end

@protocol RootViewModelDelegate

/// When invoked, should return a cold signal that prepares for a route to be
/// handled and then completes. Should not error or send values. Should be used
/// to clean up existing UI, if needed. If no cleanup is necessary, should
/// return an empty signal.
- (RACSignal *)prepareForRouting;

@end

@interface RootViewModel : NSObject<AUTRoutable>

@property (readonly, nonatomic) AUTRouter *router;

@property (nonatomic, weak) id<RootViewModelPresenter> presenter;
@property (nonatomic, weak) id<RootViewModelDelegate> delegate;

@property (readonly, nonatomic) RACCommand<id, TabBarViewModel *> *presentTabBar;

@end

NS_ASSUME_NONNULL_END
