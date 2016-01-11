//
//  ViewController.m
//  sikuDemo
//
//  Created by 齐冲 on 15/12/22.
//  Copyright © 2015年 齐冲. All rights reserved.
//

#import "ViewController.h"
#import "SQMySegment.h"
@interface ViewController ()<UISearchControllerDelegate>
@property (nonatomic,strong)SQMySegment *segment;
@property (nonatomic,strong)UISearchController *searchBarController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar addSubview:self.segment];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, self.view.frame.size.height - 64)];
    table.tableHeaderView = self.searchBar.searchBar;
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
- (UISearchController *)searchBar
{
    if (!_searchBarController) {
        _searchBarController = [[UISearchController alloc] initWithSearchResultsController:nil];
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

- (SQMySegment *)segment
{
    if (!_segment) {
        _segment = [[SQMySegment alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50 ) andTitleArrary:@[@"分类",@"品牌"] andSelectedBlock:^(NSInteger index) {
            NSLog(@"%ld",(long)index);
        }];
    }
    return _segment;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
