//
//  FAQViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "FAQViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FAQViewModel

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    
    _title = @"FAQ";
    
    _content = @"This would be some FAQ content if it actually existed...";
    
    return self;
}

#pragma mark - FAQViewModel<TitledViewModel>

@synthesize title = _title;

@end

NS_ASSUME_NONNULL_END
