//
//  YARecommendInterestViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendInterestViewController.h"
#import "YARecommendTopicPageMenuViewController.h"
#import "YARecommendInterestCatRequest.h"

@interface YARecommendInterestViewController ()
/** 直接跳到的分类标题 */
@property (nonatomic, copy) NSString *catTitle;
@end

@implementation YARecommendInterestViewController

#pragma mark – Life Cycle

- (instancetype)initWithCatTitle:(NSString *)title {
    if (self = [super init]) {
        _catTitle = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 配置
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    YARecommendInterestCatRequest *request = [[YARecommendInterestCatRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        YARecommendTopicPageMenuViewController *pageViewController = [[YARecommendTopicPageMenuViewController alloc] initWithResponseObject:request.responseObject];
        
        [self addChildViewController:pageViewController];
        [self.view addSubview:pageViewController.view];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
