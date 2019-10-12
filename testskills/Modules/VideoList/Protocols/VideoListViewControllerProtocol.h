//
//  VideoListViewControllerProtocol.h
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoListPresenter;
@protocol VideoListControllerProtocol <NSObject>

@property (nonatomic, strong, readonly) VideoListPresenter* presenter;

- (void)updateTableView;

@end
