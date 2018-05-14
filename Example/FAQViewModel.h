//
//  FAQViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import Foundation;

#import "TitledViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQViewModel : NSObject<TitledViewModel>

@property (readonly, nonatomic) NSString *content;

@end

NS_ASSUME_NONNULL_END
