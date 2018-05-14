//
//  CatComposeViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;
@import AUTPresentations;

#import "AUTExtObjC.h"
#import "Cat.h"

#import "CatComposeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatComposeViewModel () {
    RACReplaySubject<Cat *> *_result;
}

@end

@implementation CatComposeViewModel

- (instancetype)init {
    self = [super init];
    
    _title = @"Create Cat";
    
    _result = [RACReplaySubject replaySubjectWithCapacity:0];
    [self.rac_willDeallocSignal subscribe:_result];
    
    _create = [RACCommand aut_oneShotCommandWithSignalBlock:^(NSString *name) {
        AUTCAssertNotNil(name);
        let cat = [Cat catWithImageName:AUTRandomCatImageName() name:name];
        return [RACSignal return:cat];
    }];
    
    _cancel = [RACCommand aut_cancelCommandWithResult:_result];
    
    [[[_create.aut_values
        take:1]
        takeUntil:_cancel.executionSignals]
        subscribe:_result];
    
    return self;
}

#pragma mark - CatComposeViewModel<TitledViewModel>

@synthesize title = _title;

#pragma mark - CatComposeViewModel<AUTCancellableViewModel>

@synthesize cancel = _cancel;

@end

NS_ASSUME_NONNULL_END
