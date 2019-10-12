//
//  VideoListPresenterProtocol.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoListViewController;
@class Video;

@protocol VideoListPresenterProtocol <NSObject>

@required
- (instancetype)initWithView:(VideoListViewController *)view;
- (NSUInteger)countVideos;
- (Video*)videoWithIndexPath:(NSIndexPath*)indexPath;
- (void)continueLoading;
- (void)loadByString:(NSString*)search;
- (void)showLoadingSpinner;
- (void)removeLoadingSpinner;
- (BOOL)isSpinnerActive;

@end
