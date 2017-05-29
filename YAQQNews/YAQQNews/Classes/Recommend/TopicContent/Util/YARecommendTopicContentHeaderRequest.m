//
//  YARecommendTopicContentHeaderRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicContentHeaderRequest.h"

@interface YARecommendTopicContentHeaderRequest ()
@property (nonatomic, copy) NSString *topicID;
@end
@implementation YARecommendTopicContentHeaderRequest

// 初始化方法
- (instancetype)initWithTopicID:(NSString *)topicID {
    if (self = [super init]) {
        _topicID = topicID;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getTopicItem?tpid=%@",self.topicID];
}
@end

