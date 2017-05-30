//
//  YAAppRecommendItem.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/30.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAAppRecommendItem.h"
#import "YAAppRecommendRequest.h"
#import <MJExtension.h>

@implementation YAAppRecommendItem
+ (void)loadAppRecommendItemAndBannerCompletionBlockWithSuccess:(YALoadAppRecommendItemSuccessBlock)success failure:(YALoadAppRecommendItemFailureBlock)failure {

    YAAppRecommendRequest *request = [[YAAppRecommendRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSArray *itemArray = [YAAppRecommendItem appRecommendItemArrayWithKayValues:request.responseObject[@"apps"]];
        success(itemArray, request.responseObject[@"banner"][@"url"], request.responseObject[@"banner"][@"img"]);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure(request.error);
    }];
}

 #pragma mark – Private Methods

// 字典数组转模型数组
+ (NSArray <YAAppRecommendItem *> *)appRecommendItemArrayWithKayValues:(NSArray *)array {
    return [YAAppRecommendItem mj_objectArrayWithKeyValuesArray:array];
}
@end
