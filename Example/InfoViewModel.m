//
//  InfoViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "InfoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation InfoViewModel

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    
    _title = @"Info";
    
    _presentFAQ = [RACCommand aut_presentFAQCommandWithViewModel:self];
    
    return self;
}

#pragma mark - InfoViewModel<TitledViewModel>

@synthesize title = _title;

#pragma mark - InfoViewModel<FAQPresentingViewModel>

@synthesize presentFAQ = _presentFAQ;

@end

NS_ASSUME_NONNULL_END
