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
    Loading,
    LoadingWithString
};

@class Video;
@protocol VideoListInteractorProtocol <NSObject>

-(void)startLoading:(TypeLoading)type searchName:(NSString*)searchName;
- (Video*)getVideoWithIndexPath:(NSIndexPath*)indexPath;
- (NSUInteger)getCountVideos;
- (BOOL)isFullLoaded;

@end
