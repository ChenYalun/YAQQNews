//
//  YARecommendTopicContentListRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface YARecommendTopicContentListRequest : YTKRequest
// 初始化方法:请求分类新闻列表
- (instancetype)initWithCategoryID:(NSString *)topicID newsList:(NSArray *)ids;
@end
