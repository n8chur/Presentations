//
//  ImageViewController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"
#import "ImageViewModel.h"
#import "ImageContentView.h"

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (null_resettable, nonatomic) ImageContentView *view;

@property (readonly, nonatomic, copy, nullable) UIImageView *imageView;

@property (readonly, nonatomic) ImageViewModel *viewModel;

@end

@implementation ImageViewController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewModel:(ImageViewModel *)viewModel {
    AUTAssertNotNil(viewModel);
    
    self = [super initWithNibName:nil bundle:nil];
    
    _viewModel = viewModel;
    
    self.title = viewModel.title;
    
    return self;
}

#pragma mark - UIViewController

@dynamic view;

- (void)loadView {
    self.view = [[ImageContentView alloc] initWithImage:self.viewModel.image frame:UIScreen.mainScreen.bounds];
    self.view.delegate = self;
}

#pragma mark - ImageViewController<UIScrollViewDelegate>

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.view.imageView;
}

@end
