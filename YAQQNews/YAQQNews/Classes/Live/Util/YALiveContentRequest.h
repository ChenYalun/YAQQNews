//
//  YALiveContentRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "YANewsModel.h"

// 直播内容请求
@interface YALiveContentRequest : YTKRequest
- (instancetype)initWithArticleID:(NSString *)articleId articleType:(NewsArticleType)type;;
@end
