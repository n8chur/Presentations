//
//  FAQPresenter.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import AUTPresentations;

@class FAQViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol FAQPresenter

- (id<AUTDismissiblePresentation>)presentFAQ:(FAQViewModel *)faq;

@end

@protocol FAQPresentingViewModel

@property (weak, nonatomic) id<FAQPresenter> presenter;

/// Presents the FAQ.
///
/// The execution argument is an animated<BOOL>.
///
/// Its execution signals send the FAQ being presented immediately, and then
/// complete once presentation has finished.
@property (nonatomic) RACCommand<NSNumber *, FAQViewModel *> *presentFAQ;

@end

@interface RACCommand (FAQPresenter)

/// @return @see -[FAQPresentingViewModel presentFAQ]
+ (RACCommand<NSNumber *, FAQViewModel *> *)aut_presentFAQCommandWithViewModel:(id<FAQPresentingViewModel>)viewModel;

@end

NS_ASSUME_NONNULL_END
