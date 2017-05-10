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

   
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.liveContentHeaderView.frame = CGRectMake(0, 20, self.view.width, 180);
    
    YALiveContentPageViewController *pageMenuViewController = [[YALiveContentPageViewController alloc] init];
    
    [self addChildViewController:pageMenuViewController];
    
    [self.view addSubview:pageMenuViewController.view];
    self.pageMenuViewController = pageMenuViewController;
    
    
    pageMenuViewController.view.frame = CGRectMake(0, 200, self.view.width, self.view.height - 200);
    
    
    
    
    
    
    
    
    
    
    
    
    
    YALiveContentRequest *request = [[YALiveContentRequest alloc] initWithArticleID:self.news.ID articleType:self.news.articletype];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        YALiveContent *content = [YALiveContent liveContentWithKeyValue:request.responseObject];
        
        self.liveContentHeaderView.headContent = content;
        
        if (content.comments) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"666" object:nil userInfo:@{@"comments": content.comments}];
        NSLog(@"%@", content);
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.error);
    }];
    
    
    
    

     
     
}

- (YALiveContentHeaderView *)liveContentHeaderView {
    if (!_liveContentHeaderView) {
        _liveContentHeaderView = [YALiveContentHeaderView liveContentHeaderView];
        [self.view addSubview:_liveContentHeaderView];
    }
    return _liveContentHeaderView;
}
@end
