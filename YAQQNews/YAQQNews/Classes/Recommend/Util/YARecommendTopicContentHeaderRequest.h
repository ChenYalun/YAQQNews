//
//  YARecommendTopicContentHeaderRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface YARecommendTopicContentHeaderRequest : YTKRequest
// 初始化方法
- (instancetype)initWithTopicID:(NSString *)topicID;
@end
