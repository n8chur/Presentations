//
//  UITabBarController+AUTPresentation.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/16/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"
#import "AUTPresentation.h"

#import "UITabBarController+AUTPresentation.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UITabBarController (AUTPresentation)

- (id<AUTPresentation>)aut_presentationForViewController:(UIViewController *)viewController {
    AUTAssertNotNil(viewController);

    @weakify(self);

    return [[AUTPresentation alloc] initWithPresentedViewController:viewController present:^(UIViewController *presentedViewController, BOOL animated) {
        @strongifyOr(self) return [RACSignal empty];

        self.selectedViewController = presentedViewController;
        return [RACSignal empty];
    }];
}

@end

NS_ASSUME_NONNULL_END
