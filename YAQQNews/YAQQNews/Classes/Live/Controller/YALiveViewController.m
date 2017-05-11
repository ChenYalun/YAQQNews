//
//  YALiveViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/5.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveViewController.h"

#import "YALivePageMenuViewController.h"

@interface YALiveViewController ()


@end


@implementation YALiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置tabbar隐藏
    self.hidesBottomBarWhenPushed = YES;
    
    // 设置导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    YALivePageMenuViewController *pageMenuViewController = [[YALivePageMenuViewController alloc] init];
    
    [self addChildViewController:pageMenuViewController];
    
    [self.view addSubview:pageMenuViewController.view];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

@end
