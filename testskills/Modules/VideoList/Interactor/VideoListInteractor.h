//
//  VideoListInteractor.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include "VideoListInteractorProtocol.h"
#import "GetCounts+NSArray.h"

@interface VideoListInteractor : NSObject <VideoListInteractorProtocol>

@property (nonatomic, weak) id<VideoListInteractorDelegate> delegate;

@end
