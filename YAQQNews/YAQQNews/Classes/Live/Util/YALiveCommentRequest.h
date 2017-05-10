//
//  YALiveCommentRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface YALiveCommentRequest : YTKRequest
- (instancetype)initWithArticleID:(NSString *)articleId lastID:(NSString *)lastID;
@end
