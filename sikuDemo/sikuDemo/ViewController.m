//
//  ViewController.m
//  sikuDemo
//
//  Created by 齐冲 on 15/12/22.
//  Copyright © 2015年 齐冲. All rights reserved.
//

#import "ViewController.h"
#import "SQMySegment.h"
#import "SQSearchHotVc.h"
@interface ViewController ()<UISearchControllerDelegate,UISearchDisplayDelegate,UISearchBarDelegate>
{
    UIViewController *_controller;
}
@property (nonatomic,strong)SQMySegment *segment;
@property (nonatomic,strong)UISearchController *searchBarController;
@property (nonatomic,strong)UISearchDisplayController *displayController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar addSubview:self.segment];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, self.view.frame.size.height - 64)];
//    table.backgroundColor = [UIColor cyanColor];
    table.tableHeaderView = self.displayController.searchBar;
    [self.view addSubview:table];
    // Do any additional setup after loading the view, typically from a nib.
}

//- (void)willDismissSearchController:(UISearchController *)searchController
//{
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)didDismissSearchController:(UISearchController *)searchController
//{
//    self.navigationController.navigationBar.hidden = YES;
//}
- (UISearchController *)searchBarController
{
    if (!_searchBarController) {
        UITableViewController *table = [[UITableViewController alloc] init];
       
        _searchBarController = [[UISearchController alloc] initWithSearchResultsController:table];
        _searchBarController.delegate = self;
       
        _searchBarController.searchBar.placeholder = @"搜索商品或品牌";
        [_searchBarController.searchBar sizeToFit];
        for (UIView *view in _searchBarController.searchBar.subviews) {
            if ([view isKindOfClass:[UIView class]]) {
                for (UIView *subView in view.subviews) {
                    if ([subView isKindOfClass:[NSClassFromString(@"UISearchBarBackground") class]]) {
                        [subView removeFromSuperview];
                    }
                    if ([subView isKindOfClass:[NSClassFromString(@"UISearchBarTextField") class]]) {
                        subView.backgroundColor = KThemColor;
                    }
                }
            }
        }
    }
    return _searchBarController;
}

- (UISearchDisplayController *)displayController
{
    if (!_displayController) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        
        _displayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        _displayController.delegate = self;
        _displayController.searchBar.delegate = self;
        _displayController.searchBar.placeholder = @"搜索商品或品牌";
        
        for (UIView *view in _displayController.searchBar.subviews) {
            if ([view isKindOfClass:[UIView class]]) {
                for (UIView *subView in view.subviews) {
                    if ([subView isKindOfClass:[NSClassFromString(@"UISearchBarBackground") class]]) {
                        [subView removeFromSuperview];
                    }
                    if ([subView isKindOfClass:[NSClassFromString(@"UISearchBarTextField") class]]) {
                        subView.backgroundColor = KThemColor;
                    }
                }
            }
        }
    }
    return _displayController;
}

- (SQMySegment *)segment
{
    if (!_segment) {
        //y = 1 是为了遮住nav下边的线
        _segment = [[SQMySegment alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 44 ) andTitleArrary:@[@"分类",@"品牌"] andSelectedBlock:^(NSInteger index) {
            NSLog(@"%ld",(long)index);
        }];
    }
    return _segment;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    SQSearchHotVc *hot = [[SQSearchHotVc alloc] init];
    _controller = hot;
    [self.view addSubview:hot.view];
    [self.view bringSubviewToFront:hot.view];

    hot.view.frame = CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        hot.view.frame = CGRectMake(0,65, self.view.frame.size.width, self.view.frame.size.height-1);
    }];
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    for (UIView *view1 in controller.searchContentsController.view.subviews) {
        if ([view1 isKindOfClass:[NSClassFromString(@"UISearchDisplayControllerContainerView") class]]) {
            for (UIView *view2 in view1.subviews) {
                for (UIView *view3 in view2.subviews) {
                    NSLog(@"%@",[view3 class]);
                    if ([view3 isKindOfClass:[NSClassFromString(@"_UISearchDisplayControllerDimmingView") class]]) {
                        [view3 removeFromSuperview];
                    }
                }
            }
            
        }
        
    }

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if (_controller) {
        [_controller.view removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
