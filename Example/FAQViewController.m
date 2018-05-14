//
//  FAQViewController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"
#import "FAQViewModel.h"
#import "StackContentView.h"

#import "FAQViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQViewController ()

@property (null_resettable, readonly, nonatomic) StackContentView *view;

@end

@implementation FAQViewController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithFAQViewModel:(FAQViewModel *)viewModel {
    AUTAssertNotNil(viewModel);
    
    self = [super initWithNibName:nil bundle:nil];
    
    _viewModel = viewModel;
    
    self.title = viewModel.title;
    
    return self;
}

#pragma mark - UIViewController

@dynamic view;

- (void)loadView {
    self.view = [[StackContentView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.view.label.text = self.viewModel.title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    let content = [[UILabel alloc] init];
    content.numberOfLines = 0;
    content.textAlignment = NSTextAlignmentCenter;
    content.text = self.viewModel.content;
    [self.view.stackView addArrangedSubview:content];
}

@end

NS_ASSUME_NONNULL_END
