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
    
    dispatch_group_t groupRequestList;
    dispatch_group_t groupRequestID;
    
    //parametrs
    
}

- (instancetype)init{
    if (self = [super init]) {
        network = [NetworkManager new];
        videosIDs = [NSMutableArray new];
        videos = [NSMutableArray new];
        currentObjectInPage = 0;
        currentPage = 1;
        
    }
    return self;
}

- (NSUInteger)getCountVideos {
    return [self isEmptyPosts] ? videos.count : 0;
}

- (BOOL)isEmptyPosts{
    return videos != nil && videos.count > 0;
}

- (NSUInteger)getLimitVideos {
    return [network getLimitVideos];
}

- (void)getMoreVideos:(NSString *)searchName {
    __weak typeof(self) weakSelf = self;
    
    [network getMoreVideos:[@(currentPage) stringValue] success:^(NSArray<NSDictionary *> * _Nonnull objects) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf && objects) {
                //self->videosIDs = objects;
            }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"Something wrong");
    }];

}

- (Video *)getVideoWithIndexPath:(NSIndexPath *)indexPath {
    return [self isEmptyPosts] ? [videos objectAtIndex:indexPath.row] : nil;
}

- (void)getVideos:(NSString*)searchName {
    __weak typeof(self) weakSelf = self;
    
    [network getVideos:[@(currentPage) stringValue] success:^(NSArray<NSDictionary *> * _Nonnull objects) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf && objects) {
                for (int i = 0; i < objects.count;i++){
                    if(![self->videosIDs isEqualToConstForDownload] || self->videosIDs.count == 0){
                        [self->videosIDs addObject:[objects[i] objectForKey:@"imdbID"]];
                       self->currentObjectInPage++;
                    }
                }
                if([self->videosIDs isEqualToConstForDownload] && self->videosIDs.count != 0){
                    dispatch_group_leave(self->groupRequestList);
                }else{
                    self->currentPage++;
                    [self getVideos:searchName];
                }
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
                if([self->videos isEqualToConstForDownload]){
                    //NSLog(@"Compleate: %lu , %lu",(unsigned long)self->videos.count, (unsigned long)self->videosIDs.count);
                    NSLog(@"Compleate");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate updateVideos];
                        NSLog(@"Все загружено");
                    });
                }
            });
}

-(void)startLoading:(TypeLoading)type searchName:(NSString*)searchName{
    groupRequestList = dispatch_group_create();
    
    dispatch_group_enter(groupRequestList);

    dispatch_group_async(groupRequestList, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if(type == NewLoading){
            [self getVideos:searchName];
        }else{
            [self getMoreVideos:searchName];
        }
    });
    
    dispatch_queue_t queueRequstVideosById = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_group_notify(groupRequestList, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Загрузка списка завершена! \nНачинаю загрузку элементов");
//        NSLog(@"parametrs.currentPage :%ld\nparametrs.currentObjectInPage:%ld",(long)self->currentPage,(long)self->currentObjectInPage);
//        NSLog(@"countvidos:%lu",(unsigned long)self->videosIDs.count);

        dispatch_sync(queueRequstVideosById, ^{
            [self startLoadingByID];
        });
    });
}

@end
