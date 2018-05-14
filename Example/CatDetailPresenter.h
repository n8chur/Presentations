//
//  CatDetailPresenter.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import AUTPresentations;

#import "ImagePresenter.h"

@class CatDetailViewModel;
@class Cat;

NS_ASSUME_NONNULL_BEGIN

@protocol CatDetailPresenter <ImagePresenter>

- (id<AUTDismissiblePresentation>)presentCatDetail:(CatDetailViewModel *)detail;

@end

@protocol CatDetailPresentingViewModel <ImagePresentingViewModel>

@property (weak, nonatomic) id<CatDetailPresenter> presenter;

/// Presents a detail view for a cat.
///
/// The execution argument tuple should be a (cat, animated<BOOL>).
///
/// Its execution signals send the cat detail being presented immediately, and
/// then complete once presentation has finished.
@property (nonatomic) RACCommand<RACTwoTuple<Cat *, NSNumber *> *, CatDetailViewModel *> *presentCatDetail;

@end

@interface RACCommand (CatDetailPresenter)

/// @return @see -[CatDetailPresentingViewModel presentCatDetail]
+ (RACCommand<RACTwoTuple<Cat *, NSNumber *> *, CatDetailViewModel *> *)aut_presentCatDetailCommandWithViewModel:(id<CatDetailPresentingViewModel>)viewModel;

@end

NS_ASSUME_NONNULL_END
