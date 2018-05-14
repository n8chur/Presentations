//
//  FAQPresenter.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;
@import AUTPresentations;

#import "FAQViewModel.h"
#import "AUTExtObjC.h"

#import "FAQPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (FAQPresenter)

+ (RACCommand<NSNumber *, FAQViewModel *> *)aut_presentFAQCommandWithViewModel:(id<FAQPresentingViewModel>)viewModel {
    @weakify(viewModel);
    
    return [RACCommand aut_presentCommandWithExecutionBlock:^ AUTPresentCommandExecutionContext * _Nullable (NSNumber *animated) {
        @strongify(viewModel);
        let presenter = viewModel.presenter;
        if (presenter == nil) return nil;
        
        let faq = [[FAQViewModel alloc] init];
        
        let presentation = [presenter presentFAQ:faq];
        return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:faq animated:animated];
    }];
}

@end

NS_ASSUME_NONNULL_END
