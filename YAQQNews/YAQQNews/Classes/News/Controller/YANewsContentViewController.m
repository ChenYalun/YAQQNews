//
//  YANewsContentViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContentViewController.h"
#import "YANewsModel.h"
#import "YANavigationView.h"
#import "YANewsContentTextViewController.h"
#import "YANewsContentCommentViewController.h"

@interface YANewsContentViewController ()
/** 新闻模型 */
@property (nonatomic, strong) YANewsModel *news;
/** scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 导航视图 */
@property (nonatomic, strong) YANavigationView *navigationView;
@end

@implementation YANewsContentViewController

 #pragma mark – Life Cycle
- (instancetype)initWithNews:(YANewsModel *)news {
    if (self = [super init]) {
        _news = news;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控制器相关设置
    self.hidesBottomBarWhenPushed = YES;
    
    // View相关属性
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    // 添加子视图
    YANewsContentTextViewController *textViewController = [[YANewsContentTextViewController alloc] initWithNews:self.news];
    [self addChildViewController:textViewController];
    [self.scrollView addSubview:textViewController.view];
    textViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    YANewsContentCommentViewController *commentViewController = [[YANewsContentCommentViewController alloc] initWithNews:self.news];
    [self addChildViewController:commentViewController];
    [self.scrollView addSubview:commentViewController.view];
    commentViewController.view.frame = CGRectMake(self.view.width, 44, self.view.width, self.view.height);
    
    
    // 添加导航视图
    [self.view addSubview:self.navigationView];
    
    
}

 #pragma mark – Getters and Setters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        _scrollView.contentSize = CGSizeMake(self.view.width * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (YANavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [YANavigationView navigationViewWithTitle:self.news.title];
        _navigationView.frame = CGRectMake(0, 20, self.view.width, 44);
    }
    return _navigationView;
}
@end
