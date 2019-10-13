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
    BOOL                       spinnerActive;
    NSString                    *searchName;
}

- (instancetype)init{
    NSAssert(YES, @"Wrong initializer");
    return nil;
}

- (instancetype)initWithView:(VideoListViewController *)view {
    if (self = [super init]) {
        
        self->view   = view;
        interactor   = [VideoListInteractor new];
        
        spinnerActive = false;
        
        interactor.delegate = self;
        searchName = @"bat";
        [interactor startLoading:Loading searchName:searchName];
    }
    return self;
}

-(BOOL)isSpinnerActive{
    return spinnerActive;
}

- (void)continueLoading{
    [interactor startLoading:Loading searchName:searchName];
}
- (void)loadByString:(NSString*)search{
    searchName = search;
    [interactor startLoading:LoadingWithString searchName:searchName];
}

-(void)showLoadingSpinner{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleMedium];
    [spinner startAnimating];
    spinner.frame = CGRectMake(0, 0, 320, 44);
    spinnerActive = YES;
    [view setLoadingSpinner:spinner];
}
-(void)removeLoadingSpinner{
    spinnerActive = NO;
    [view closeLoadingSpinner];
}

#pragma mark - Interactor

- (NSUInteger)countVideos{
    return [interactor getCountVideos];
}

- (BOOL)isFullLoaded{
    return [interactor isFullLoaded];
}

- (Video*)videoWithIndexPath:(NSIndexPath*)indexPath{
    return [interactor getVideoWithIndexPath:indexPath];
}

#pragma mark - Interactor Delegate

- (void)updateVideos{
    [view updateTableView];
    [self removeLoadingSpinner];
}

@end
