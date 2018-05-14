//
//  Cat.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface Cat : NSObject

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)catWithImageName:(NSString *)imageName name:(NSString *)name;

@property (readonly, nonatomic) NSUInteger objectID;

@property (readonly, nonatomic, copy) NSString *imageName;

@property (readonly, nonatomic, copy) NSString *name;

@end

extern NSString * AUTRandomCatImageName();

NS_ASSUME_NONNULL_END
