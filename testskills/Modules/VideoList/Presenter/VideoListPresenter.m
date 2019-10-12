//
//  VideoListPresenter.m
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import "VideoListPresenter.h"
#import "VideoListViewController.h"
#import "VideoListInteractor.h"

@implementation VideoListPresenter{
    __weak VideoListViewController *view;
    VideoListInteractor            *interactor;
}

- (instancetype)init{
    NSAssert(YES, @"Wrong initializer");
    return nil;
}

- (instancetype)initWithView:(VideoListViewController *)view {
    if (self = [super init]) {
        
        self->view   = view;
        interactor   = [VideoListInteractor new];
        
        interactor.delegate = self;
        [interactor startLoading:NewLoading searchName:@"bat"];
    }
    return self;
}

#pragma mark - Interactor

- (NSUInteger)countVideos{
    return [interactor getCountVideos];
}

- (Video*)videoWithIndexPath:(NSIndexPath*)indexPath{
    return [interactor getVideoWithIndexPath:indexPath];
}

#pragma mark - Interactor Delegate

- (void)updateVideos{
    [view updateTableView];
}

@end
