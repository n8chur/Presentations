//
//  Cat.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "Cat.h"

NS_ASSUME_NONNULL_BEGIN

@interface Cat ()

- (instancetype)initWithImageName:(NSString *)imageName name:(NSString *)name NS_DESIGNATED_INITIALIZER;

@end

@implementation Cat

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithImageName:(NSString *)imageName name:(NSString *)name {
    AUTAssertNotNil(imageName, name);
    
    self = [super init];
    
    static NSUInteger objectID = 0;
    objectID++;
    _objectID = objectID;
    
    _imageName = [imageName copy];
    _name = [name copy];
    
    return self;
}

+ (instancetype)catWithImageName:(NSString *)imageName name:(NSString *)name {
    return [[self alloc] initWithImageName:imageName name:name];
}

@end

static NSArray<NSString *> * CatImageNames() {
    static dispatch_once_t onceToken;
    static NSArray<NSString *> * imageNames;
    dispatch_once(&onceToken, ^{
        imageNames = @[
            @"Cat1",
            @"Cat2",
            @"Cat3",
            @"Cat4",
            @"Cat5",
            @"Cat6",
        ];
    });
    return imageNames;
}

NSString * AUTRandomCatImageName() {
    let names = CatImageNames();
    return names[arc4random() % names.count];
}

NS_ASSUME_NONNULL_END
