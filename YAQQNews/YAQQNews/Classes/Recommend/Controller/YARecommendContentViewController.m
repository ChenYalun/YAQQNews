//
//  YARecommendContentViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendContentViewController.h"
#import "YAChannelViewController.h"

@interface YARecommendContentViewController ()

@end

@implementation YARecommendContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    
//    YAChannelViewController *channelViewController = [[YAChannelViewController alloc] init];
//    [self addChildViewController:channelViewController];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
//    label.backgroundColor = [UIColor redColor];
//    [self.view addSubview:label];
//    [self.view addSubview:channelViewController.view];
//    channelViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    channelViewController.tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
    self.view.backgroundColor = [UIColor grayColor];
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
