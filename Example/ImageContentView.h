//
//  ImageContentView.h
//  Example
//
//  Created by Westin Newell on 6/22/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ImageContentView : UIScrollView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@property (readonly, nonatomic) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
