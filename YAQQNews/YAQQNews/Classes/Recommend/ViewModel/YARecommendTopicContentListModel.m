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

 #pragma mark – Private Methods

// 字典数组转模型数组
+ (NSArray *)topicContentListWithKeyValues:(id)keyValues {
    return [YARecommendTopicContentListModel mj_objectArrayWithKeyValuesArray:keyValues[@"newslist"]];
}
@end
