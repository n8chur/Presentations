//
//  AUTCancellableViewModel.m
//  AUTPresentations
//
//  Created by Eric Horacek on 5/8/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "AUTCancellableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (AUTCancellableViewModel)

+ (RACCommand *)aut_cancelCommandWithResult:(RACSignal *)result {
    return [self aut_cancelCommandWithResult:result signalBlock:^(id _Nullable _) {
        return [RACSignal empty];
    }];
}

+ (RACCommand *)aut_cancelCommandWithResult:(RACSignal *)result signalBlock:(RACSignal<id> * (^)(id _Nullable))signalBlock {
    AUTAssertNotNil(result, signalBlock);

    let enabled = [RACSubject subject];

    RACCommand *command = [[self alloc] initWithEnabled:enabled signalBlock:signalBlock];

    // Sends NO whenever result sends a completed or error event.
    let noUponResult = [[[[result materialize]
        map:^(RACEvent *event) {
            switch (event.eventType) {
            case RACEventTypeCompleted:
            case RACEventTypeError:
                return @NO;
            default:
                return @YES;
            }
        }]
        ignore:@YES]
        take:1];

    // Sends NO whenever the command is executed.
    let noUponExecution = [[command.executionSignals take:1] mapReplace:@NO];

    // Disable the command in either case.
    [[RACSignal merge:@[ noUponResult, noUponExecution ]]
        subscribe:enabled];

    return command;
}

- (RACCommand *)aut_wrappedCancelCommandWithResult:(RACSignal *)result {
    AUTAssertNotNil(result);

    return [RACCommand aut_cancelCommandWithResult:result signalBlock:^(id input) {
        return [self execute:input];
    }];
}

@end

NS_ASSUME_NONNULL_END
