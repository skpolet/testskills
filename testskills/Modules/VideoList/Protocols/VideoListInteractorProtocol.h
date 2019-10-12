//
//  VideoListInteractorProtocol.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoListInteractorDelegate.h"

typedef NS_ENUM(NSInteger, TypeLoading) {
    NewLoading,
    MoreLoading
};

@class Video;
@protocol VideoListInteractorProtocol <NSObject>

//- (void)getVideos;
//- (void)getMoreVideos;
//- (void)getVideos:(NSString*)searchName;
//- (void)getVideosByID;
-(void)startLoading:(TypeLoading)type searchName:(NSString*)searchName;
- (Video*)getVideoWithIndexPath:(NSIndexPath*)indexPath;
- (NSUInteger)getCountVideos;
//- (BOOL)isEqualToConstForDownload;
- (NSUInteger)getLimitVideos;

@end
