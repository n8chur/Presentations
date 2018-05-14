//
//  RACCommand+AUTPresentationSpec.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/15/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

SpecBegin(RACCommand_AUTPresentation)

describe(@"AUTPresentCommandExecutionContext", ^{
    __block BOOL success;
    __block NSError *error;
    
    beforeEach(^{
        success = NO;
        error = nil;
    });
    
    describe(@"deallocation", ^{
        it(@"should occur", ^{
            RACSignal *willDealloc;
            @autoreleasepool{
                let viewController = [[UIViewController alloc] init];
                let present = ^(UIViewController *_1, BOOL _2){
                    return [RACSignal empty];
                };
                let presentation = [[AUTPresentation alloc] initWithPresentedViewController:viewController present:present];
                let context = [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:nil animated:nil];
                willDealloc = context.rac_willDeallocSignal;
            }
            success = [willDealloc asynchronouslyWaitUntilCompleted:&error];
            expect(success).to.beTruthy();
            expect(error).to.beNil();
        });
    });
});

describe(@"aut_cancelCommandWithResult:", ^{
    it(@"should return a RACCommand", ^{
        let executionBlock = ^(id _){
            let viewController = [[UIViewController alloc] init];
            let present = ^(UIViewController *_1, BOOL _2){
                return [RACSignal empty];
            };
            let presentation = [[AUTPresentation alloc] initWithPresentedViewController:viewController present:present];
            return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:nil animated:nil];
        };
        let command = [RACCommand aut_presentCommandWithExecutionBlock:executionBlock];
        expect(command).to.beAKindOf(RACCommand.class);
    });
});

SpecEnd

NS_ASSUME_NONNULL_END
