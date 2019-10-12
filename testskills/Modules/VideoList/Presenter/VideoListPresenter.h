//
//  VideoListPresenter.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoListPresenterProtocol.h"
#import "VideoListInteractorDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoListPresenter : NSObject <VideoListPresenterProtocol, VideoListInteractorDelegate>

@end

NS_ASSUME_NONNULL_END
