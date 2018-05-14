//
//  CatComposePresenter.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;
@import AUTPresentations;

#import "CatComposeViewModel.h"
#import "AUTExtObjC.h"

#import "CatComposePresenter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (CatComposePresenter)

+ (RACCommand<NSNumber *, CatComposeViewModel *> *)aut_presentCatComposeCommandWithViewModel:(id<CatComposePresentingViewModel>)viewModel {
    @weakify(viewModel);
    
    return [RACCommand aut_presentCommandWithExecutionBlock:^ AUTPresentCommandExecutionContext * _Nullable (NSNumber *animated) {
        AUTCAssertNotNil(animated);
        
        @strongify(viewModel);
        let presenter = viewModel.presenter;
        if (presenter == nil) return nil;
        
        let composeViewModel = [[CatComposeViewModel alloc] init];
        
        let presentation = [presenter presentCatCompose:composeViewModel];
        return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:composeViewModel animated:animated];
    }];
}

@end

NS_ASSUME_NONNULL_END
