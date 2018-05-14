//
//  InfoViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import Foundation;

#import "TitledViewModel.h"
#import "FAQPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoViewModel : NSObject<TitledViewModel, FAQPresentingViewModel>

@property (weak, nonatomic) id<FAQPresenter> presenter;

@end

NS_ASSUME_NONNULL_END
