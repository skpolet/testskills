//
//  VideoListViewController+TableView.m
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import "VideoListViewController+TableView.h"
#import "VideoListPresenter.h"
#import "VideoListCell.h"

@implementation VideoListViewController (TableView)

@end

@interface VideoListViewController (UITableViewDelegate) <UITableViewDelegate>
@end

@implementation VideoListViewController (UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

@end

@interface VideoListViewController (UITableViewDataSource) <UITableViewDataSource>
@end

NSString * const kCellName = @"VideoListCell";

@implementation VideoListViewController (UITableViewDataSource)

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    VideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (cell == nil) {
        cell = [[VideoListCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:kCellName];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Video *video = [self.presenter videoWithIndexPath:indexPath];
    [cell configure:video];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.presenter countVideos];
}

@end
