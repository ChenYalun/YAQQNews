//
//  YANewsCommentRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/17.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface YANewsCommentRequest : YTKRequest
- (instancetype)initWithCommentID:(NSString *)commentID page:(NSUInteger)page;
@end
