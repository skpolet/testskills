//
//  VideoListCell.m
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import "VideoListCell.h"
#import "Video.h"

@implementation VideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure:(Video*)video{
    if(![video.posterUrl isEqualToString:@"N/A"]){
        NSURL* imageUrl = [NSURL URLWithString:video.posterUrl];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.poster.image = img;
            });
        });
    }
    self.genre.text = video.genre;
    self.title.text = video.title;
    self.year.text = video.year;
}

@end
