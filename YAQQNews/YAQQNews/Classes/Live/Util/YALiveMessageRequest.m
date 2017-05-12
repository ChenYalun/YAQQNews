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
/** 评论ID */
@property (nonatomic, copy) NSString *commentID;
/** 文章类型 */
@property (nonatomic, assign) NewsArticleType articleType;
@end
@implementation YALiveMessageRequest
- (instancetype)initWithArticleID:(NSString *)articleId aboutPageCommentID:(NSString *)commentID replyID:(NSString *)replyID articleType:(NewsArticleType)articleType {
    if (self = [super init]) {
        _articleID = articleId;
        _replyID = replyID;
        _commentID = commentID;
        _articleType = articleType;
    }
    return self;
}

// 请求URL
- (NSString *)requestUrl {
    
    if (self.articleType == NewsArticleTypeAboutLive) {
        return [NSString stringWithFormat:@"http://r.inews.qq.com/getBarrageList?article_id=%@&comment_id=%@&old_reply_id=%@", self.articleID, self.commentID, self.replyID];
    } else {
        return [NSString stringWithFormat:@"http://r.inews.qq.com/getQQNewsRoseComments?article_id=%@&reply_id=%@&comment_id=&rose_id", self.articleID, self.replyID];
    }
    
}

// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
