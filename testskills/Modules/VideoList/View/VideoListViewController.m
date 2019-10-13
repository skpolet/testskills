//
//  VideoListViewController.m
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoListPresenter.h"

@interface VideoListViewController ()

@end

@implementation VideoListViewController

@synthesize presenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    presenter = [[VideoListPresenter alloc] initWithView:self];
}

- (void)setLoadingSpinner:(UIActivityIndicatorView *)spinner{
    self.tableView.tableFooterView = spinner;
}

- (void)closeLoadingSpinner{
    NSLog(@"zashlo");
    self.tableView.tableFooterView = nil;
}

- (void)updateTableView{
    [self.tableView reloadData];
}

@end
