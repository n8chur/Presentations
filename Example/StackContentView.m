//
//  StackContentView.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/22/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "StackContentView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation StackContentView

#pragma mark - Lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    
    _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[ _label ]];
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.spacing = 10;
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_stackView];
    [NSLayoutConstraint activateConstraints:@[
        [_stackView.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
        [_stackView.centerYAnchor constraintEqualToAnchor: self.centerYAnchor],
        [_stackView.leftAnchor constraintGreaterThanOrEqualToAnchor:self.leftAnchor],
        [_stackView.rightAnchor constraintGreaterThanOrEqualToAnchor:self.rightAnchor],
    ]];
    
    self.backgroundColor = UIColor.whiteColor;
    
    return self;
}

#pragma mark - UIView

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end

NS_ASSUME_NONNULL_END
