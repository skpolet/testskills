//
//  VideoListViewController+SearchBar.m
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import "VideoListViewController+SearchBar.h"
#import "VideoListPresenter.h"

@implementation VideoListViewController (SearchBar)

@end

@interface VideoListViewController (SearchBarDelegate) <UISearchBarDelegate>
@end

@implementation VideoListViewController (SearchBarDelegate)

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    SEL selector = @selector(loadByString:);
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:selector object:nil];
//    [self.presenter performSelector:selector withObject:searchText afterDelay:1];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    @try
    {
        searchBar.showsCancelButton = NO;
        [searchBar resignFirstResponder];
    }
    @catch (NSException *exception) {
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.presenter loadByString:searchBar.text];
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

@end
