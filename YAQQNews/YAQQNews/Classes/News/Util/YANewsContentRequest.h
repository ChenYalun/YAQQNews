//
//  YANewsContentRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface YANewsContentRequest : YTKRequest
- (instancetype)initWithArticleID:(NSString *)articleID;
@end
