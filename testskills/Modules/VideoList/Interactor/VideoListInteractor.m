//
//  VideoListInteractor.m
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import "VideoListInteractor.h"
#import "NetworkManager.h"

@implementation VideoListInteractor{
    NSMutableArray  <Video *>* videos;
    NSMutableArray  * videosIDs;
    NetworkManager* network;
    
    NSInteger currentObjectInPage;
    NSInteger currentPage;
    NSInteger limitVideos;
    
    dispatch_group_t groupRequestList;
    dispatch_group_t groupRequestID;
}

- (instancetype)init{
    if (self = [super init]) {
        network = [NetworkManager new];
        videos = [NSMutableArray new];
        currentObjectInPage = 0;
        currentPage = 1;
        limitVideos = 0;
    }
    return self;
}

- (NSUInteger)getCountVideos {
    return [self isEmptyVideos] ? videos.count : 0;
}

- (BOOL)isFullLoaded{
    return limitVideos == videos.count ? YES : NO;
}

- (BOOL)isEmptyVideos{
    return videos != nil && videos.count > 0;
}

- (Video *)getVideoWithIndexPath:(NSIndexPath *)indexPath {
    return [self isEmptyVideos] ? [videos objectAtIndex:indexPath.row] : nil;
}

- (void)getVideos:(NSString*)searchName {
    __weak typeof(self) weakSelf = self;
    [network getVideos:searchName page:[@(currentPage) stringValue] success:^(NSArray<NSDictionary *> * _Nonnull objects) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf && objects) {
                for (int i = 0; i < objects.count;i++){
                    if(![self->videosIDs isEqualToConstForDownload] || self->videosIDs.count == 0){
                        [self->videosIDs addObject:[objects[i] objectForKey:@"imdbID"]];
                       self->currentObjectInPage++;
                    }
                }
                if([self->videosIDs isEqualToConstForDownload] && self->videosIDs.count != 0){
                    self->currentPage++;
                    dispatch_group_leave(self->groupRequestList);
                }else if(self->limitVideos == self->currentObjectInPage){
                    dispatch_group_leave(self->groupRequestList);
                }else{
                    self->currentPage++;
                    [self getVideos:searchName];
                }
            }
        if(objects.count == 0){
            dispatch_group_leave(self->groupRequestList);
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"Something wrong");
    }];
}

-(void)startLoadingByID{
        dispatch_group_t groupRequestID = dispatch_group_create();
        
            for (NSString * videoID in videosIDs) {
                dispatch_group_wait(groupRequestID, DISPATCH_TIME_FOREVER);
                dispatch_group_enter(groupRequestID);
                __weak typeof(self) weakSelf = self;
                [network getVideosByID: groupRequestID videoID: videoID success:^(Video * _Nonnull video) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                        if (strongSelf && video) {
                            [self->videos addObject:video];
                        }
                } failure:^(NSError * _Nonnull error) {
                    NSLog(@"Something wrong");
                }];
            }
            

            dispatch_group_notify(groupRequestID, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if([self->videos isEqualToConstForDownload] || self->videos.count == self->limitVideos){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate updateVideos];
                        NSLog(@"Все загружено");
                    });
                }
            });
}

-(void)getTotalVideos:(NSString*)searchName{
    __weak typeof(self) weakSelf = self;
    [self->network getLimitVideos:searchName success:^(NSInteger limitVideos) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf && limitVideos) {
                self->limitVideos = limitVideos;
            }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"Something wrong");
    }];
}

-(void)startLoading:(TypeLoading)type searchName:(NSString*)searchName{
    
    [self getTotalVideos:searchName];
    
    groupRequestList = dispatch_group_create();
        dispatch_group_enter(groupRequestList);
    
        if(type == Loading){
            self->videosIDs = [NSMutableArray new];
               [self getVideos:searchName];
        }else{
            self->videos = [NSMutableArray new];
            self->videosIDs = [NSMutableArray new];
            self->currentObjectInPage = 0;
            self->currentPage = 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate updateVideos];
            });
            [self getVideos:searchName];
        }
    
    dispatch_queue_t queueRequstVideosById = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_group_notify(groupRequestList, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Загрузка списка завершена! \nНачинаю загрузку элементов");
        dispatch_sync(queueRequstVideosById, ^{
            [self startLoadingByID];
        });
    });
}

@end
