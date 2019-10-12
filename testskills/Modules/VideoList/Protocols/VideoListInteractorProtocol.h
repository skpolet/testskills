//
//  VideoListInteractorProtocol.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoListInteractorDelegate.h"

@class Video;
@protocol VideoListInteractorProtocol <NSObject>

- (void)getVideos;
- (void)getMoreVideos;
- (NSUInteger)getLimitVideos;
- (void)getVideos:(NSString*)searchName;
- (Video*)getVideoWithIndexPath:(NSIndexPath*)indexPath;
- (NSUInteger)getContVideos;

@end
