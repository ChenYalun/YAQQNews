//
//  YALiveMessageRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveMessageRequest.h"

@interface YALiveMessageRequest ()
/** 新闻id */
@property (nonatomic, copy) NSString *articleID;
/** 上次message最后一个id */
@property (nonatomic, copy) NSString *replyID;
@end
@implementation YALiveMessageRequest
- (instancetype)initWithArticleID:(NSString *)articleId replyID:(NSString *)replyID {
    if (self = [super init]) {
        _articleID = articleId;
        _replyID = replyID;
    }
    return self;
}

// 请求URL
- (NSString *)requestUrl {
    
    
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getQQNewsRoseComments?article_id=%@&reply_id=%@&comment_id=&rose_id", self.articleID, self.replyID];
    
}

// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
