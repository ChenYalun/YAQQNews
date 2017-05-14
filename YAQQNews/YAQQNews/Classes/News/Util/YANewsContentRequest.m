//
//  YANewsContentRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContentRequest.h"

@interface YANewsContentRequest ()
/** 文章ID */
@property (nonatomic, copy) NSString *articleID;
@end

@implementation YANewsContentRequest
- (instancetype)initWithArticleID:(NSString *)articleID {
    if (self = [super init]) {
        _articleID = articleID;
    }
    return self;
}

// 请求URL

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getSimpleNews/10.2.1_qqnews_5.3.4/news_news_top/%@/", self.articleID];;
}
// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
