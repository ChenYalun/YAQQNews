//
//  YALiveContentRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveContentRequest.h"

@interface YALiveContentRequest ()
/** 新闻id */
@property (nonatomic, copy) NSString *articleID;
/** 新闻类型 */
@property (nonatomic, assign) NewsArticleType articleType;
@end

@implementation YALiveContentRequest

- (instancetype)initWithArticleID:(NSString *)articleId articleType:(NewsArticleType)type {
    if (self = [super init]) {
        _articleID = articleId;
        _articleType = type;
    }
    return self;
}

// 请求URL
- (NSString *)requestUrl {
    
    if (self.articleType == NewsArticleTypeAboutLive) {
        return [NSString stringWithFormat:@"http://r.inews.qq.com/getLiveNewsContent?article_id=%@", self.articleID];

    } else {
        return [NSString stringWithFormat:@"http://r.inews.qq.com/getQQNewsRoseContent?article_id=%@&chlid&rose_id", self.articleID];
    }
    
}

// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}



@end
