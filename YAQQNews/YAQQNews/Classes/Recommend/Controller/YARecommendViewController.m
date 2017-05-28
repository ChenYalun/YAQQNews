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

@interface YARecommendViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *discoverLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchButtonLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeadingConstraint;
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

 #pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 右边关闭按钮的颜色渐变与旋转/搜索按钮的移动
    if (scrollView.contentOffset.x < kScreenWidth) {
        self.closeButton.alpha = 1 - scrollView.contentOffset.x / kScreenWidth;
        self.closeButton.transform = CGAffineTransformMakeRotation((1 - scrollView.contentOffset.x / kScreenWidth ) * M_PI_2);
        self.searchButtonLeadingConstraint.constant =  15 + (1 - scrollView.contentOffset.x / kScreenWidth) * 5;
    }
    
    // 标题/发现 的移动与颜色渐变
    if (scrollView.contentOffset.x < kScreenWidth && scrollView.contentOffset.x > kScreenWidth / 3) {
        self.titleLabelLeadingConstraint.constant = kScreenWidth - scrollView.contentOffset.x;
        self.titleLabel.alpha = 1 - (kScreenWidth - scrollView.contentOffset.x) / (kScreenWidth / 4);
        self.discoverLabel.alpha = 1 - (kScreenWidth - scrollView.contentOffset.x) / (kScreenWidth / 2);
    }
    
    // 搜索按钮的旋转
    if (scrollView.contentOffset.x < kScreenWidth && scrollView.contentOffset.x >= 0.5 * kScreenWidth) {
        self.searchButton.transform = CGAffineTransformMakeRotation((kScreenWidth - scrollView.contentOffset.x) / (kScreenWidth / 2) * M_PI_4 * (-0.5));
    } else if (scrollView.contentOffset.x < 0.5 * kScreenWidth) {
        self.searchButton.transform = CGAffineTransformMakeRotation((1 - (kScreenWidth * 0.5  - scrollView.contentOffset.x) / (kScreenWidth * 0.5)) * M_PI_4 * (-0.5));
    }
    
    // tabBar透明度
    if (scrollView.contentOffset.x <= 100) {
        self.tabBarController.tabBar.alpha = (scrollView.contentOffset.x - 40) / 60;
    } else {
        self.tabBarController.tabBar.alpha = 1.0;
    }
}

 #pragma mark – Events

// scrollView滑到第二页
- (IBAction)returnRecommendPage:(UIButton *)sender {
    // 默认展示第二页
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
}


#pragma mark – Getters and Setters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.contentSize = CGSizeMake(2 * kScreenWidth, kScreenHeight);
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
@end
