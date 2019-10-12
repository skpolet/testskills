//
//  NetworkManager.m
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import "NetworkManager.h"

NSString * const nameUrl   = @"http://www.omdbapi.com/";
NSString * const apiKey   = @"c2aa2348";

@implementation NetworkManager

- (void)getVideos:(NSString*)searchName
   page:(NSString*)page
success:(void (^)(NSArray<NSDictionary *>* objects))success
failure:(void (^)(NSError* error))failure{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?s=%@&apikey=%@&page=%@&plot=full",nameUrl,searchName,apiKey,page]]];
    
     [request setHTTPMethod:@"GET"];
    NSLog(@"url:%@",request.URL);

         NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
         [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             
             if (error) {
                 failure(error);
                 return;
             }
             
             NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
             
         if ([@(httpResponse.statusCode) isEqualToNumber:@200] && requestReply && requestReply.length > 0) {
             NSData * responseData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
                 
             NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
             
             NSArray * searchArray = [jsonDict objectForKey:@"Search"];
             success(searchArray);
         }

     }] resume];
}

- (void)getVideosByID:(dispatch_group_t)groupRequestID
              videoID:(NSString*)videoID
              success:(void (^)(Video * video))success
              failure:(void (^)(NSError* error))failure{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?i=%@&apikey=%@",nameUrl,videoID,apiKey]]];
     [request setHTTPMethod:@"GET"];
    NSLog(@"url:%@",[NSString stringWithFormat:@"%@?i=%@&apikey=%@",nameUrl,videoID,apiKey]);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];


        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error) {
                dispatch_group_leave(groupRequestID);
                failure(error);
                return;
            }

            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if ([@(httpResponse.statusCode) isEqualToNumber:@200] && requestReply && requestReply.length > 0) {
                NSData * responseData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
                    
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];

                Video * video = [Video new];
                video.genre = [jsonDict objectForKey:@"Genre"];
                video.posterUrl = [jsonDict objectForKey:@"Poster"];
                video.title = [jsonDict objectForKey:@"Title"];
                video.year = [jsonDict objectForKey:@"Year"];
                
                dispatch_group_leave(groupRequestID);
                success(video);
                
            }else{
                dispatch_group_leave(groupRequestID);
            }
                
    }] resume];
    
}

-(void)getLimitVideos:(NSString*)searchName
              success:(void (^)(NSInteger limitVideos))success
              failure:(void (^)(NSError* error))failure{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?s=%@&apikey=%@&plot=full",nameUrl,searchName,apiKey]]];
    
     [request setHTTPMethod:@"GET"];

         NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
         [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             
             if (error) {
                 failure(error);
                 return;
             }
             
             NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
             
         if ([@(httpResponse.statusCode) isEqualToNumber:@200] && requestReply && requestReply.length > 0) {
             NSData * responseData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
                 
             NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
             
             NSString * countItems = [jsonDict objectForKey:@"totalResults"];
             success([countItems integerValue]);
         }

     }] resume];
}

@end
