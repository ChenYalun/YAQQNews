//
//  YANewsCommentRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/17.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsCommentRequest.h"

@interface YANewsCommentRequest ()
/** 文章ID */
@property (nonatomic, copy) NSString *commentID;
/** 页码 */
@property (nonatomic, copy) NSString *page;

@end


@implementation YANewsCommentRequest
- (instancetype)initWithCommentID:(NSString *)commentID page:(NSUInteger)page {
    if (self = [super init]) {
        _commentID = commentID;
        _page = [NSString stringWithFormat:@"%ld", page];
    }
    return self;
}

// 请求URL
- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getQQNewsComment?comment_id=%@&page=%@", self.commentID, self.page];;
}
// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end
