//
//  ImageViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "ImageViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ImageViewModel

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title {
    AUTAssertNotNil(imageName, title);
    
    self = [super init];
    
    _title = [title copy];
    _image = [UIImage imageNamed:imageName];
    
    return self;
}

#pragma mark - ImageViewModel<TitledViewModel>

@synthesize title = _title;

@end

NS_ASSUME_NONNULL_END
