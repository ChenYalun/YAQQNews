//
//  YARecommendViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/5.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendViewController.h"
#import "YARecommendContentViewController.h"
#import "YARecommendDiscoverViewController.h"

@interface YARecommendViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation YARecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view insertSubview:self.scrollView atIndex:0];
    
    YARecommendDiscoverViewController *discoverViewController = [[YARecommendDiscoverViewController alloc] init];
    [self addChildViewController:discoverViewController];
    [self.scrollView addSubview:discoverViewController.view];
    discoverViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    YARecommendContentViewController *contentViewController = [[YARecommendContentViewController alloc] init];
    [self addChildViewController:contentViewController];
    [self.scrollView addSubview:contentViewController.view];
    contentViewController.view.frame = CGRectMake(kScreenWidth, 64, kScreenWidth, kScreenHeight - 64);
    
    // 默认展示第二页
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    
    
    
}

#pragma mark – Getters and Setters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.contentSize = CGSizeMake(2 * kScreenWidth, kScreenHeight);
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
@end
