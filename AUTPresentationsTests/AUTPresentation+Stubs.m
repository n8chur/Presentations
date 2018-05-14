//
//  AUTPresentation+Stubs.m
//  Automatic
//
//  Created by Eric Horacek on 10/10/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import UIKit;

#import "AUTExtObjC.h"

#import "AUTPresentation+Stubs.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AUTPresentation (Stubs)

+ (instancetype)stubPresentation {
    return [[AUTPresentation alloc]
        initWithPresentedViewController:[[UIViewController alloc] init]
        present:^(UIViewController *vc, BOOL animated) {
            return [RACSignal empty];
        }];
}

@end

@implementation AUTDismissiblePresentation (Stubs)

+ (instancetype)stubPresentation {
    return [[AUTDismissiblePresentation alloc]
        initWithPresentedViewController:[[UIViewController alloc] init]
        present:^(UIViewController *vc, BOOL animated) {
            return [RACSignal empty];
        }
        dismiss:^(UIViewController * presentedViewController, BOOL animated) {
            return [RACSignal empty];
        }
        didDismiss:nil];
}

@end

@implementation AUTResultPresentation (Stubs)

+ (instancetype)stubPresentationWithResult:(RACSignal *)result {
    AUTAssertNotNil(result);

    return [[AUTResultPresentation alloc]
        initWithPresentedViewController:[[UIViewController alloc] init]
        present:^(UIViewController * _Nonnull presentedViewController, BOOL animated) {
            return [RACSignal empty];
        }
        dismiss:^(UIViewController * _Nonnull presentedViewController, BOOL animated) {
            return [RACSignal empty];
        }
        didDismiss:nil
        result:result];
}

@end

NS_ASSUME_NONNULL_END
