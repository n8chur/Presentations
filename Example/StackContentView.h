//
//  StackContentView.h
//  AUTPresentations
//
//  Created by Westin Newell on 6/22/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface StackContentView : UIView

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@property (readonly, nonatomic) UIStackView *stackView;

/// A label that is added as the only arranged subview in the stackView at init
/// time.
@property (readonly, nonatomic) UILabel *label;

@end

NS_ASSUME_NONNULL_END
