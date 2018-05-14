//
//  AUTPresentationSpec.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/15/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

SpecBegin(AUTPresentation)

__block BOOL success;
__block NSError *error;

beforeEach(^{
    success = NO;
    error = nil;
});

describe(@"lifecycle", ^{
    describe(@"deallocation", ^{
        it(@"should occur", ^{
            RACSignal *willDealloc;
            @autoreleasepool{
                let viewController = [[UIViewController alloc] init];
                let present = ^(UIViewController *_1, BOOL _2){
                    return [RACSignal empty];
                };
                let presentation = [[AUTPresentation alloc] initWithPresentedViewController:viewController present:present];
                willDealloc = presentation.rac_willDeallocSignal;
            }
            success = [willDealloc asynchronouslyWaitUntilCompleted:&error];
            expect(success).to.beTruthy();
            expect(error).to.beNil();
        });
    });
});

SpecEnd

NS_ASSUME_NONNULL_END
