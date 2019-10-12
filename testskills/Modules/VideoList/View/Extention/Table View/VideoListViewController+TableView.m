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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Video *video = [self.presenter videoWithIndexPath:indexPath];
    NSLog(@"ВЫделенный элемент:%@",video.title);
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
        NSInteger lastRow = indexPath.row;
        
    if(lastRow == [self.presenter countVideos] - 1){
        if(![self.presenter isFullLoaded]){
        [self.presenter showLoadingSpinner];
        [self.presenter continueLoading];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if([self.presenter countVideos] == 0){
        UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
        emptyLabel.text = @"Подождите, записи грузятся";
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        self.tableView.backgroundView = emptyLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        NSLog(@"count:%lu",(unsigned long)[self.presenter countVideos]);
        return [self.presenter countVideos];
    }
}

@end
