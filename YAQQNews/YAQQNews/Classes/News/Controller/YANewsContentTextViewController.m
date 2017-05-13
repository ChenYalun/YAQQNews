//
//  YANewsContentTextViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContentTextViewController.h"
#import "YANewsModel.h"
#import "YANewsContentRequest.h"
#import "YANewsContent.h"
#import "YANewsContentTitleView.h"

@interface YANewsContentTextViewController ()
/** 新闻模型 */
@property (nonatomic, strong) YANewsModel *news;
/** 标题视图 */
@property (nonatomic, strong) YANewsContentTitleView *titleView;
@end

@implementation YANewsContentTextViewController

 #pragma mark – Life Cycle

- (instancetype)initWithNews:(YANewsModel *)news {
    if (self = [super init]) {
        _news = news;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // View相关设置
    [self.view addSubview:self.titleView];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    YANewsContentRequest *request = [[YANewsContentRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        YANewsContent *content = [YANewsContent newsContentWithObject:request.responseObject news:self.news];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        kLog(@"%@", request.error);
    }];
    
}

 #pragma mark – Getters and Setters

-(YANewsContentTitleView *)titleView {
    if (!_titleView) {
        _titleView = [YANewsContentTitleView contentTitleViewWithNews:self.news];
        CGFloat height = _titleView.height;
        _titleView.frame = CGRectMake(0, 44, self.view.width, height);
    }
    return _titleView;
}

@end
