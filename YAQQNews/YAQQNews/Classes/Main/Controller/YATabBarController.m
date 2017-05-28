//
//  YATabBarController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/5.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YATabBarController.h"
#import "YANewsViewController.h"
#import "YARecommendViewController.h"
#import "YALiveViewController.h"
#import "YAProfileViewController.h"
#import "YATabBarItem.h"

@interface YATabBarController ()

@end

@implementation YATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // 设置tabbar控制器
    YANewsViewController *newsViewController = [[YANewsViewController alloc] init];
    UINavigationController *newsNavigationController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
    
    YARecommendViewController *recommendViewController = [[YARecommendViewController alloc] init];
    UINavigationController *recommendNavigationController = [[UINavigationController alloc] initWithRootViewController:recommendViewController];
    
    YALiveViewController *liveViewController = [[YALiveViewController alloc] init];
    UINavigationController *liveNavigationController = [[UINavigationController alloc] initWithRootViewController:liveViewController];
    
    YAProfileViewController *profileViewController = [[YAProfileViewController alloc] init];
    UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    
    self.viewControllers = @[newsNavigationController, recommendNavigationController, liveNavigationController, profileNavigationController];
    
    // 创建Item
    YATabBarItem *newsItem = [[YATabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"tabbar_news_normal"]  selectedImage:[UIImage imageNamed:@"tabbar_news_selected"]];
    YATabBarItem *recommendItem = [[YATabBarItem alloc] initWithTitle:@"推荐" image:[UIImage imageNamed:@"tabbar_recommend_normal"] selectedImage:[UIImage imageNamed:@"tabbar_recommend_selected"]];
    YATabBarItem *liveItem = [[YATabBarItem alloc] initWithTitle:@"直播" image:[UIImage imageNamed:@"tabbar_live_normal"] selectedImage:[UIImage imageNamed:@"tabbar_live_selected"]];
    YATabBarItem *profileItem = [[YATabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_me_normal"] selectedImage:[UIImage imageNamed:@"tabbar_me_selected"]];
    
    newsViewController.tabBarItem = newsItem;
    recommendViewController.tabBarItem = recommendItem;
    liveViewController.tabBarItem = liveItem;
    profileViewController.tabBarItem = profileItem;
    
    // 设置tabbar属性
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
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
