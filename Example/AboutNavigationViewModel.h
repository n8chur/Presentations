//
//  AboutNavigationViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTRouting;

#import "TitledViewModel.h"

@class InfoViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface AboutNavigationViewModel : NSObject<TitledViewModel, AUTRoutable>

@property (readonly, nonatomic) InfoViewModel *infoViewModel;

@end

NS_ASSUME_NONNULL_END
