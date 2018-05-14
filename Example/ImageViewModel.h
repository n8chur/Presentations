//
//  ImageViewModel.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

#import "TitledViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewModel : NSObject<TitledViewModel>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic, copy) UIImage *image;

@end

NS_ASSUME_NONNULL_END
