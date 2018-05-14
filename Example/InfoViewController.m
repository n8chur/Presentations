//
//  InfoViewController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;

#import "AUTExtObjC.h"
#import "FAQViewController.h"
#import "StackContentView.h"

#import "InfoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoViewController () <FAQPresenter>

@property (readonly, nonatomic) AUTModalPresenter *modalPresenter;

@property (null_resettable, readonly, nonatomic) StackContentView *view;

@end

@implementation InfoViewController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewModel:(InfoViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter {
    AUTAssertNotNil(viewModel, modalPresenter);
    
    self = [super initWithNibName:nil bundle:nil];
    
    _viewModel = viewModel;
    _viewModel.presenter = self;
    
    _modalPresenter = modalPresenter;
    
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
    
    let presentFAQButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [presentFAQButton setTitle:@"FAQ" forState:UIControlStateNormal];
    presentFAQButton.rac_command = [self.viewModel.presentFAQ aut_commandWithExecutionValue:@YES];
    [self.view.stackView addArrangedSubview:presentFAQButton];
}

#pragma mark - InfoViewController<FAQPresenter>

- (id<AUTDismissiblePresentation>)presentFAQ:(FAQViewModel *)faq {
    let viewController = [[FAQViewController alloc] initWithFAQViewModel:faq];
    
    let navigationViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    let dismissButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:NULL];
    viewController.navigationItem.leftBarButtonItem = dismissButton;
    
    let presentation = [self.modalPresenter presentationForViewController:navigationViewController];
    dismissButton.rac_command = [presentation.dismiss aut_commandWithExecutionValue:@YES];
    
    return presentation;
}

@end

NS_ASSUME_NONNULL_END
