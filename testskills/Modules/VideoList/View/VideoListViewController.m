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

- (void)updateTableView{
    [self.tableView reloadData];
}

@end
