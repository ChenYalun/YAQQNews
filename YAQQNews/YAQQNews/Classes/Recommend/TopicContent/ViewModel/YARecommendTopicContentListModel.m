//
//  YARecommendTopicContentListModel.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicContentListModel.h"
#import "YARecommendTopicContentListRequest.h"
#import <MJExtension.h>
#import "YARecommendSubNewsRequest.h"

@implementation YARecommendTopicContentListModel
+ (void)loadTopicContentListForArray:(NSMutableArray *)topicList topicID:(NSString *)topicID ids:(NSMutableArray *)ids isFirst:(BOOL)isFirst completionBlockWithSuccess:(YALoadNewsListSuccessBlock)success failure:(YALoadNewsListFailureBlock)failure {
    
    YARecommendTopicContentListRequest *request = [[YARecommendTopicContentListRequest alloc] initWithCategoryID:topicID newsList:ids];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSArray *array = [NSArray arrayWithArray:[YARecommendTopicContentListModel topicContentListWithKeyValues:request.responseObject]];
        [topicList addObjectsFromArray:array];
        
        // 获取所有ID
        if (isFirst) {
            [request.responseObject[@"ids"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ids addObject:obj[@"id"]];
            }];
        }

        
        success(topicList);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure(request.error);
    }];

}

+ (void)loadIDArrayWithChildID:(NSString *)childID completionBlockWithSuccess:(YALoadTopicNewsListSuccessBlock)success failure:(YALoadTopicNewsListFailureBlock)failure {
    YARecommendSubNewsRequest *request = [[YARecommendSubNewsRequest alloc] initWithChildID:childID];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        // id数组
        NSMutableArray *idArray = [NSMutableArray array];
        [request.responseObject[@"ids"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [idArray addObject:obj[@"id"]];
        }];
        
        // 新闻数组
        NSMutableArray *topicArray = [NSMutableArray array];
        [topicArray addObjectsFromArray:[YARecommendTopicContentListModel topicContentListWithKeyValues:request.responseObject]];
        success(topicArray, idArray);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure(request.error);
    }];

}

+ (void)loadTopicSubscribeListWithIDArray:(NSArray *)idArray completionBlockWithSuccess:(YALoadTopicSubscribeListSuccessBlock)success failure:(YALoadTopicSubscribeListFailureBlock)failure {
    YARecommendSubNewsRequest *request = [[YARecommendSubNewsRequest alloc] initWithNewsIdArray:idArray];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        // 新闻数组
        NSMutableArray *topicSubArray = [NSMutableArray array];
        [topicSubArray addObjectsFromArray:[YARecommendTopicContentListModel topicContentListWithKeyValues:request.responseObject]];
        success(topicSubArray);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure(request.error);
    }];
}

 #pragma mark – Private Methods

// 字典数组转模型数组
+ (NSArray *)topicContentListWithKeyValues:(id)keyValues {
    return [YANewsModel newsModelWithOriginKeyValues:keyValues[@"newslist"]];
}
@end
