//
//  AUTCancellableViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/15/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

SpecBegin(AUTCancellableViewModel)

describe(@"aut_cancelCommandWithResult:", ^{
    it(@"should return a RACCommand", ^{
        let command = [RACCommand aut_cancelCommandWithResult:[RACSignal empty]];
        expect(command).to.beAKindOf(RACCommand.class);
    });
});

describe(@"aut_cancelCommandWithResult:signalBlock:", ^{
    it(@"should return a RACCommand", ^{
        let signalBlock = ^(id _){
            return [RACSignal empty];
        };
        let command = [RACCommand aut_cancelCommandWithResult:[RACSignal empty] signalBlock:signalBlock];
        expect(command).to.beAKindOf(RACCommand.class);
    });
});

describe(@"aut_wrappedCancelCommandWithResult:", ^{
    it(@"should return a RACCommand", ^{
        let innerCommand = [[RACCommand alloc] initWithSignalBlock:^(id _){
            return [RACSignal empty];
        }];
        let command = [innerCommand aut_wrappedCancelCommandWithResult:[RACSignal empty]];
        expect(command).to.beAKindOf(RACCommand.class);
    });
});

SpecEnd

NS_ASSUME_NONNULL_END
