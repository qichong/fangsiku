//
//  SQSearchHotVc.m
//  sikuDemo
//
//  Created by 齐冲 on 16/1/12.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import "SQSearchHotVc.h"

@interface SQSearchHotVc ()

@end

@implementation SQSearchHotVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KThemColor;
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end