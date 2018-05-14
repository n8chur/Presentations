//
//  CatComposeViewController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/21/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "CatComposeViewModel.h"
#import "AUTExtObjC.h"
#import "StackContentView.h"

#import "CatComposeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatComposeViewController () <UITextFieldDelegate>

@property (readonly, nonatomic) UITextField *textField;

@property (null_resettable, readonly, nonatomic) StackContentView *view;

@end

@implementation CatComposeViewController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewModel:(CatComposeViewModel *)viewModel {
    AUTAssertNotNil(viewModel);
    
    self = [super initWithNibName:nil bundle:nil];
    
    _viewModel = viewModel;
    
    _textField = [[UITextField alloc] init];
    _textField.placeholder = @"Name";
    _textField.delegate = self;
    
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
    
    [self.view.stackView addArrangedSubview:self.textField];
    [self.textField.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    
    let cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:NULL];
    cancelButton.rac_command = self.viewModel.cancel;
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    let doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:NULL];
    @weakify(self);
    doneButton.rac_command = [[RACCommand alloc] initWithEnabled:self.viewModel.create.enabled signalBlock:^ RACSignal<Cat *> * (id _) {
        @strongifyOr(self) return [RACSignal empty];
        
        return [self.viewModel.create execute:self.textField.text ?: @""];
    }];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

#pragma mark - CatComposeViewController<UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.viewModel.create execute:self.textField.text ?: @""];
    return NO;
}

@end

NS_ASSUME_NONNULL_END
