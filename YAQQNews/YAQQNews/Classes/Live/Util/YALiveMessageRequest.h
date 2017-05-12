//
//  YALiveMessageRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "YANews.h"

@interface YALiveMessageRequest : YTKRequest
- (instancetype)initWithArticleID:(NSString *)articleId aboutPageCommentID:(NSString *)commentID replyID:(NSString *)replyID articleType:(NewsArticleType)articleType;
@end
