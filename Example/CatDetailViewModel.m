//
//  CatDetailViewModel.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "Cat.h"
#import "AUTExtObjC.h"

#import "CatDetailViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CatDetailViewModel

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithCat:(Cat *)cat {
    AUTAssertNotNil(cat);
    
    self = [super init];
    
    _cat = cat;
    
    _title = cat.name;
    _image = [UIImage imageNamed:cat.imageName];
    
    _selectImage = [[RACCommand alloc] initWithSignalBlock:^(id _) {
        return [RACSignal return:cat];
    }];
    
    return self;
}

#pragma mark - CatDetailViewModel<TitledViewModel>

@synthesize title = _title;

@end

NS_ASSUME_NONNULL_END
