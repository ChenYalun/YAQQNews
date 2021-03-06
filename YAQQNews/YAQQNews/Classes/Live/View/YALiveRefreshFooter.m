//
//  YALiveRefreshFooter.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/11.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveRefreshFooter.h"

@implementation YALiveRefreshFooter
- (instancetype)init {
    if (self = [super init]) {
        self.refreshingTitleHidden = YES;
        [self setTitle:@"" forState:MJRefreshStateIdle];
        [self setTitle:@"" forState:MJRefreshStatePulling];
        [self setTitle:@"" forState:MJRefreshStateNoMoreData];
    }
    return self;
}
@end
