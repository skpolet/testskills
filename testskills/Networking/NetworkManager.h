//
//  NetworkManager.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetCounts+NSArray.h"
#import "Video.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

- (void)getVideos:(NSString*)searchName
             page:(NSString*)page
          success:(void (^)(NSArray<NSDictionary *>* objects))success
          failure:(void (^)(NSError* error))failure;

- (void)getVideosByID:(dispatch_group_t)groupRequestID videoID:(NSString*)videoID
              success:(void (^)(Video * video))success
              failure:(void (^)(NSError* error))failure;

-(void)getLimitVideos:(NSString*)searchName
              success:(void (^)(NSInteger limitVideos))success
              failure:(void (^)(NSError* error))failure;

@end

NS_ASSUME_NONNULL_END
