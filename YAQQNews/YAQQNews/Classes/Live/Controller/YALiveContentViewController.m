//
//  YALiveContentViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveContentViewController.h"
#import "YALiveContentRequest.h"
#import "YALiveContent.h"
#import "YALiveContentHeaderView.h"
#import "YALiveContentPageViewController.h"

@interface YALiveContentViewController ()
@property (nonatomic, strong) YALiveContentHeaderView *liveContentHeaderView;
@property (nonatomic, weak) YALiveContentPageViewController *pageMenuViewController;

@end

@implementation YALiveContentViewController

 #pragma mark – Life Cycle
- (instancetype)initWithNews:(YANewsModel *)news {
    if (self = [super init]) {
        _news = news;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

   
    // 隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.liveContentHeaderView.frame = CGRectMake(0, 20, self.view.width, 180);
    
    YALiveContentPageViewController *pageMenuViewController = [[YALiveContentPageViewController alloc] initWithUserInfo:@{@"articleID": self.news.ID, @"aTitle": @"主播厅", @"bTitle": @"100万人"}];

    
    [self addChildViewController:pageMenuViewController];
    
    [self.view addSubview:pageMenuViewController.view];
    self.pageMenuViewController = pageMenuViewController;
    
    
    pageMenuViewController.view.frame = CGRectMake(0, 200, self.view.width, self.view.height - 200);
    
    
    
    
    
    
    
    
    
    
    
    
    
    YALiveContentRequest *request = [[YALiveContentRequest alloc] initWithArticleID:self.news.ID articleType:self.news.articletype];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        YALiveContent *content = [YALiveContent liveContentWithKeyValue:request.responseObject];
        
        self.liveContentHeaderView.headContent = content;
        
        // 发送通知更新comments
        if (content.comments) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationComments" object:nil userInfo:@{@"comments": content.comments}];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.error);
    }];
    

    
    // 讨论
//    http://r.inews.qq.com/getQQNewsRoseComments?article_id=ZLV2017050701707000&reply_id=&comment_id=&rose_id

     
     
}

- (YALiveContentHeaderView *)liveContentHeaderView {
    if (!_liveContentHeaderView) {
        _liveContentHeaderView = [YALiveContentHeaderView liveContentHeaderView];
        [self.view addSubview:_liveContentHeaderView];
    }
    return _liveContentHeaderView;
}
@end
