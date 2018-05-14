//
//  CatComposeViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import AUTPresentations;

#import "TitledViewModel.h"

@class Cat;

NS_ASSUME_NONNULL_BEGIN

@interface CatComposeViewModel : NSObject<TitledViewModel, AUTCancellableViewModel>

/// When executed with a name, the command's execution signal and the result
/// signal sends a new Cat.
@property (readonly, nonatomic) RACCommand<NSString *, Cat *> *create;

/// If a cat is created this signal will send the cat and then complete.
///
/// If the cancel command is executed this signal will complete with no values.
@property (readonly, nonatomic) RACSignal<Cat *> *result;

@end

NS_ASSUME_NONNULL_END
