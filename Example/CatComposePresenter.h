//
//  CatComposePresenter.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import AUTPresentations;

@class CatComposeViewModel;
@class Cat;

NS_ASSUME_NONNULL_BEGIN

@protocol CatComposePresenter

- (id<AUTDismissiblePresentation>)presentCatCompose:(CatComposeViewModel *)compose;

@end

@protocol CatComposePresentingViewModel

@property (weak, nonatomic) id<CatComposePresenter> presenter;

/// Presents a compose view for a cat.
///
/// The execution argument should be an animated<BOOL>.
///
/// Its execution signals send the cat compose view model being presented
/// immediately, and then complete once presentation has finished.
@property (nonatomic) RACCommand<NSNumber *, CatComposeViewModel *> *presentCatCompose;

@end

@interface RACCommand (CatComposePresenter)

/// @return @see -[CatComposePresentingViewModel presentCatCompose]
+ (RACCommand<NSNumber *, CatComposeViewModel *> *)aut_presentCatComposeCommandWithViewModel:(id<CatComposePresentingViewModel>)viewModel;

@end

NS_ASSUME_NONNULL_END
