//
//  YANewsViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/5.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsViewController.h"
#import "YAPageMenuViewController.h"

@interface YANewsViewController ()

@end

@implementation YANewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    YAPageMenuViewController *pageMenuViewController = [[YAPageMenuViewController alloc] init];
    [self addChildViewController:pageMenuViewController];
    [self.view addSubview:pageMenuViewController.view];
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
