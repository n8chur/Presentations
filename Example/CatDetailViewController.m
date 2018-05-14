//
//  CatDetailViewController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"
#import "CatDetailViewModel.h"
#import "StackContentView.h"

#import "CatDetailViewController.h"

@interface CatDetailViewController ()

@property (null_resettable, readonly, nonatomic) StackContentView *view;

@end

@implementation CatDetailViewController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithDetailViewModel:(CatDetailViewModel *)viewModel {
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
    
    let button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:self.viewModel.image forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [NSLayoutConstraint activateConstraints:@[
        [button.widthAnchor constraintEqualToConstant:200],
        [button.heightAnchor constraintEqualToConstant:200],
    ]];
    
    button.rac_command = self.viewModel.selectImage;
    
    [self.view.stackView addArrangedSubview:button];
}

@end
