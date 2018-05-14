//
//  ImagePresenter.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import AUTPresentations;

@class ImageViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol ImagePresenter

- (id<AUTDismissiblePresentation>)presentImageViewModel:(ImageViewModel *)imageViewModel;

@end

@protocol ImagePresentingViewModel

@property (weak, nonatomic) id<ImagePresenter> presenter;

/// Presents an image view.
///
/// The execution argument tuple should be a (image name, title, animated<BOOL>).
///
/// Its execution signals send the cat detail being presented immediately, and
/// then complete once presentation has finished.
@property (nonatomic) RACCommand<RACThreeTuple<NSString *, NSString *, NSNumber *> *, ImageViewModel *> *presentImage;

@end

@interface RACCommand (ImagePresenter)

/// @return @see -[ImagePresentingViewModel presentImage]
+ (RACCommand<RACThreeTuple<NSString *, NSString *, NSNumber *> *, ImageViewModel *> *)aut_presentImageCommandWithViewModel:(id<ImagePresentingViewModel>)viewModel;

@end

NS_ASSUME_NONNULL_END
