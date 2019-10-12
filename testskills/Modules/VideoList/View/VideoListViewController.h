//
//  VideoListViewController.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListViewControllerProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoListViewController : UIViewController<VideoListViewControllerProtocol>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchView;

@end

NS_ASSUME_NONNULL_END
