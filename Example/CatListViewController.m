//
//  CatListViewController.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;

#import "AUTExtObjC.h"
#import "CatListViewModel.h"
#import "Cat.h"
#import "CatComposePresenter.h"
#import "CatComposeViewController.h"
#import "CatComposeViewModel.h"

#import "CatListViewController.h"

@interface UIImage (Cropped)

- (instancetype)aut_resizedImageOfSize:(CGSize)size;

@end

@interface CatListViewController () <CatComposePresenter>

@property (readonly, nonatomic) CatListViewModel *viewModel;

@property (readonly, nonatomic) AUTModalPresenter *modalPresenter;

@end

@implementation CatListViewController

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (instancetype)initWithStyle:(UITableViewStyle)style AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewModel:(CatListViewModel *)viewModel modalPresenter:(AUTModalPresenter *)modalPresenter {
    AUTAssertNotNil(viewModel, modalPresenter);
    
    self = [super initWithStyle:UITableViewStylePlain];
    
    _modalPresenter = modalPresenter;
    
    _viewModel = viewModel;
    _viewModel.presenter = self;
    
    self.title = viewModel.title;
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    let addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:NULL];
    addButton.rac_command = [_viewModel.presentCatCompose aut_commandWithExecutionValue:@YES];
    self.navigationItem.rightBarButtonItem = addButton;
    
    return self;
}

#pragma mark - CatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [[RACObserve(self.viewModel, cats)
        skip:1]
        subscribeNext:^(id _) {
            @strongifyOr(self) return;
            
            [self.tableView reloadData];
        }];
}

#pragma mark - CatListViewController<UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.cats.count;
}

static let CellIdentifier = @"Cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    let cat = self.viewModel.cats[indexPath.row];
    
    var cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = cat.name;
    
    let image = [UIImage imageNamed:cat.imageName];
    let size = (CGSize){
        .width = 40,
        .height = 40,
    };
    cell.imageView.image = [image aut_resizedImageOfSize:size];
    
    return cell;
}

#pragma mark - CatListViewController<UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    let cat = self.viewModel.cats[indexPath.row];
    [self.viewModel.select execute:cat];
}

#pragma mark - CatListViewController<CatComposePresenter>

- (id<AUTDismissiblePresentation>)presentCatCompose:(CatComposeViewModel *)compose {
    let viewController = [[CatComposeViewController alloc] initWithViewModel:compose];
    
    let navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    let presentation = [self.modalPresenter presentationForViewController:navigationController result:compose.result];
    
    return presentation;
}

@end

@implementation UIImage (Cropped)

- (instancetype)aut_resizedImageOfSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    let rect = (CGRect){ .size = size };
    [self drawInRect:rect];
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
