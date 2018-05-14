//
//  CatDetailViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;
@import ReactiveObjC;

#import "TitledViewModel.h"
#import "Cat.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatDetailViewModel : NSObject<TitledViewModel>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCat:(Cat *)cat NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic) Cat *cat;

@property (readonly, nonatomic) UIImage *image;

@property (readonly, nonatomic) RACCommand<id, Cat *> *selectImage;

@end

NS_ASSUME_NONNULL_END
