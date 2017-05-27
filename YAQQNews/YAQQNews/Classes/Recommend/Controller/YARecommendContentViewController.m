//
//  YARecommendContentViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendContentViewController.h"
#import "YAChannelViewController.h"
#import "YANotification.h"

@interface YARecommendContentViewController ()
@property (nonatomic, strong) UIButton *loginTipButton;
@end

@implementation YARecommendContentViewController

 #pragma mark – Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YAChannelViewController *channelViewController = [[YAChannelViewController alloc] init];
    [self addChildViewController:channelViewController];
    [self.view addSubview:channelViewController.view];
    channelViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    channelViewController.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];;

    [self.view addSubview:self.loginTipButton];
    
    // 添加黑线
    UIView *blackLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    blackLine.backgroundColor =  kRGBAColor(240, 240, 240, 0.7);
    [self.view addSubview:blackLine];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewOffsetChanged:) name:kYANewsListScrollViewOffsetNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


 #pragma mark – Events

- (void)scrollViewOffsetChanged:(NSNotification *)change {

    CGFloat offsetY = [change.userInfo[@"offsetY"] floatValue];
    if (offsetY > 0) {
        self.loginTipButton.origin = CGPointMake(0, 0);
    } else {
        self.loginTipButton.origin = CGPointMake(0, -offsetY);
    }

}

 #pragma mark – Getters and Setters

- (UIButton *)loginTipButton {
    if (!_loginTipButton) {
        _loginTipButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 10, 40)];
        _loginTipButton.backgroundColor = [UIColor whiteColor];
        
        // 添加底部线条
        UIView *blackLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39, self.view.width - 10, 1)];
        blackLine.backgroundColor = kRGBAColor(240, 240, 240, 0.7);
        [_loginTipButton addSubview:blackLine];
        
        // 设置文字
        NSAttributedString *attriTitle = [[NSAttributedString alloc] initWithString:@"登录刷新，看更多兴趣推荐 >" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#4485BF"]}];
        [_loginTipButton setAttributedTitle:attriTitle forState:UIControlStateNormal];
    }
    return _loginTipButton;
}
@end
