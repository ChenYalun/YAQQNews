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
#import "YANotification.h"

CGFloat const kNavigationViewHeight = 44;

@interface YANewsContentViewController () <UIScrollViewDelegate>
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    commentViewController.view.frame = CGRectMake(self.view.width, kNavigationViewHeight, self.view.width, self.view.height);
    
    
    // 添加导航视图
    [self.view addSubview:self.navigationView];
    
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turnPage) name:kYANewsContentTurnPageNotification object:nil];
}

 #pragma mark – Events 

- (void)turnPage {

    // -20是由于tableView的contentOffset,为了保持平滑
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width * 0.5, -20) animated:YES];
    self.navigationView.title = @"评论";

}

 #pragma mark - ScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 2) { // 避免误差
        self.navigationView.title = nil;
    } else {
        self.navigationView.title = @"评论";
    }
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
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (YANavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [YANavigationView navigationView];
        _navigationView.frame = CGRectMake(0, 20, self.view.width - 7, kNavigationViewHeight);
    }
    return _navigationView;
}
@end
