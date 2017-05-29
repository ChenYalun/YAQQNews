//
//  YARecommendTopicContentListModel.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsModel.h"
@class YARecommendTopicContentListModel;

/** 数据获取成功block */
typedef void(^YALoadTopicNewsListSuccessBlock)(NSArray <YARecommendTopicContentListModel *> *topicList, NSArray <NSString *> *ids);
/** 数据获取失败block */
typedef void(^YALoadTopicNewsListFailureBlock)(NSError *error);

typedef void(^YALoadTopicSubscribeListSuccessBlock)(NSArray <YARecommendTopicContentListModel *> *topicList);
typedef void(^YALoadTopicSubscribeListFailureBlock)(NSError *error);

@interface YARecommendTopicContentListModel : YANewsModel
+ (void)loadTopicContentListForArray:(NSMutableArray *)topicList topicID:(NSString *)topicID ids:(NSArray *)ids isFirst:(BOOL)isFirst  completionBlockWithSuccess:(YALoadNewsListSuccessBlock)success failure:(YALoadNewsListFailureBlock)failure;

// 获取所有id
+ (void)loadIDArrayWithChildID:(NSString *)childID completionBlockWithSuccess:(YALoadTopicNewsListSuccessBlock)success failure:(YALoadTopicNewsListFailureBlock)failure;

// 根据id数组请求数据
+ (void)loadTopicSubscribeListWithIDArray:(NSArray *)idArray completionBlockWithSuccess:(YALoadTopicSubscribeListSuccessBlock)success failure:(YALoadTopicSubscribeListFailureBlock)failure;
@end
