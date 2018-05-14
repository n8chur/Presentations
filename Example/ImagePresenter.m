//
//  ImagePresenter.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;
@import AUTPresentations;

#import "ImageViewModel.h"
#import "AUTExtObjC.h"

#import "ImagePresenter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (ImagePresenter)

+ (RACCommand<RACThreeTuple<NSString *, NSString *, NSNumber *> *, ImageViewModel *> *)aut_presentImageCommandWithViewModel:(id<ImagePresentingViewModel>)viewModel {
    @weakify(viewModel);
    
    return [RACCommand aut_presentCommandWithExecutionBlock:^ AUTPresentCommandExecutionContext * _Nullable (RACThreeTuple<NSString *, NSString *, NSNumber *> *tuple) {
        RACNTupleUnpack(tuple, imageName, title, animated);
        AUTCAssertNotNil(imageName, title, animated);
        
        @strongify(viewModel);
        let presenter = viewModel.presenter;
        if (presenter == nil) return nil;
        
        let imageViewModel = [[ImageViewModel alloc] initWithImageName:imageName title:title];
        
        let presentation = [presenter presentImageViewModel:imageViewModel];
        return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:imageViewModel animated:animated];
    }];
}

@end

NS_ASSUME_NONNULL_END
