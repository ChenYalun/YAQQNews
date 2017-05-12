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
/*
- (NSString *)request {
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getSimpleNews/10.2.1_qqnews_5.3.4/news_news_top/%@/", self.articleID];
}
*/
- (NSString *)requestUrl {
    return @"http://r.inews.qq.com/getSimpleNews/10.2.1_qqnews_5.3.4/news_news_top/NEW2017051203397700/";
}
// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

//- (id)requestArgument {
//    
//    return @{@"child":@"news_news_top",
//             @"id": @"NEW2017051203397700",
//             @"articlepage": @"1",
//             @"adcode": @"320111",
//             @"article_pos": @"7",
//             @"alg_version": @"10",
//             @"reasonInfo": @"",
//             @"articletype": @"0"
//             };
//}
@end
