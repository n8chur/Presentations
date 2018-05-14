//
//  ImageContentView.m
//  Example
//
//  Created by Westin Newell on 6/22/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "ImageContentView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ImageContentView

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame {
    AUTAssertNotNil(image);
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = UIColor.blackColor;
    self.minimumZoomScale = 0.1f;
    self.maximumZoomScale = 4.0f;
    self.zoomScale = self.minimumZoomScale;
    
    _imageView = [[UIImageView alloc] initWithImage:image];
    [_imageView sizeToFit];
    self.contentSize = _imageView.frame.size;
    
    [self addSubview:_imageView];
    
    return self;
}

@end

NS_ASSUME_NONNULL_END
