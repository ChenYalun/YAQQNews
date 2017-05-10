//
//  YALiveCommentRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveCommentRequest.h"

@interface YALiveCommentRequest ()
/** 新闻id */
@property (nonatomic, copy) NSString *articleID;
/** 上次最后一个id */
@property (nonatomic, copy) NSString *lastID;
@end

@implementation YALiveCommentRequest

- (instancetype)initWithArticleID:(NSString *)articleId lastID:(NSString *)lastID {
    if (self = [super init]) {
        _articleID = articleId;
        _lastID = lastID;
    }
    return self;
}

// 请求URL
- (NSString *)requestUrl {
    

    return [NSString stringWithFormat:@"http://r.inews.qq.com/getQQNewsRoseMsg?rose_id=&article_id=%@&lastid=%@&topid", self.articleID, self.lastID];

}

// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
