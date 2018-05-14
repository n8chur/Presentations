//
//  CatDetailPresenter.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;
@import AUTPresentations;

#import "CatDetailViewModel.h"
#import "AUTExtObjC.h"

#import "CatDetailPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (CatDetailPresenter)

+ (RACCommand<RACTwoTuple<Cat *, NSNumber *> *, CatDetailViewModel *> *)aut_presentCatDetailCommandWithViewModel:(id<CatDetailPresentingViewModel>)viewModel {
    @weakify(viewModel);
    
    return [RACCommand aut_presentCommandWithExecutionBlock:^ AUTPresentCommandExecutionContext * _Nullable (RACTwoTuple<Cat *, NSNumber *> *catAndAnimated) {
        RACNTupleUnpack(catAndAnimated, cat, animated);
        AUTCAssertNotNil(cat, animated);
        
        @strongify(viewModel);
        let presenter = viewModel.presenter;
        if (presenter == nil) return nil;
        
        let detailViewModel = [[CatDetailViewModel alloc] initWithCat:cat];
        
        [detailViewModel.selectImage.aut_values subscribeNext:^(Cat *cat) {
            @strongifyOr(viewModel) return;
            [viewModel.presentImage execute:RACTuplePack(cat.imageName, cat.name, @YES)];
        }];
        
        let presentation = [presenter presentCatDetail:detailViewModel];
        return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:detailViewModel animated:animated];
    }];
}

@end

NS_ASSUME_NONNULL_END
