//
//  AUTPresentation+Stubs.h
//  Automatic
//
//  Created by Eric Horacek on 10/10/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import <AUTPresentations/AUTPresentation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AUTPresentation (Stubs)

+ (instancetype)stubPresentation;

@end

@interface AUTDismissiblePresentation (Stubs)

+ (instancetype)stubPresentation;

@end

@interface AUTResultPresentation (Stubs)

+ (instancetype)stubPresentationWithResult:(RACSignal *)result;

@end

NS_ASSUME_NONNULL_END
