//
//  VideoListCell.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListCellProtocol.h"
#import "Video.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoListCell : UITableViewCell<VideoListCellProtocol>
@property (strong, nonatomic) IBOutlet UIImageView *poster;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *year;
@property (strong, nonatomic) IBOutlet UILabel *genre;

@end

NS_ASSUME_NONNULL_END
