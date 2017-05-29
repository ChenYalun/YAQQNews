//
//  YARecommendInterestModel.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendInterestModel.h"
#import <MJExtension.h>
#import "YARecommendInterest.h"
#import "YARecommendInterestListRequest.h"


@implementation YARecommendInterestModel
// 获取所有标题
+ (NSArray <NSString *> *)loadTitleListWithObject:(id)object {
    NSMutableArray *target = [NSMutableArray array];
    [object[@"data"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [target addObject:obj[@"catName"]];
    }];
    return [NSArray arrayWithArray:target];
}

// 获取模型数组
+ (NSArray <YARecommendInterestModel *> *)loadInterestWithObject:(id)object index:(NSUInteger)index {
    NSDictionary *dict = object[@"data"][index];
    return [YARecommendInterestModel loadInterestWithSubList:dict[@"subList"] topicList:dict[@"topicList"] index:index];
}

// 获取更多模型
+ (void)loadMoreInterestWithPage:(NSUInteger)page catID:(NSString *)catID  completionBlockWithSuccess:(YALoadInterestNewsListSuccessBlock)success failure:(YALoadInterestNewsListFailureBlock)failure {
    YARecommendInterestListRequest *request = [[YARecommendInterestListRequest alloc] initWithRefreshPage:page catID:catID];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseObject[@"data"];
        NSArray *array = [NSArray arrayWithArray:[YARecommendInterestModel loadInterestWithSubList:dict[@"subList"] topicList:dict[@"topicList"] index:0]];
        success(array);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure(request.error);
    }];
}

 #pragma mark – Private Methods

// 根据topicList和subList获取格式化后的模型
+ (NSArray <YARecommendInterestModel *> *)loadInterestWithSubList:(NSArray *)subList topicList:(NSArray *)topicList index:(NSUInteger)index{
    NSMutableArray *mutableArray = [NSMutableArray array];
    [mutableArray addObjectsFromArray:[YARecommendInterest mj_objectArrayWithKeyValuesArray:topicList]];
    [mutableArray addObjectsFromArray:[YARecommendInterest mj_objectArrayWithKeyValuesArray:subList]];
    
    
    // 格式化模型
    NSMutableArray *target = [NSMutableArray array];
    [mutableArray enumerateObjectsUsingBlock:^(YARecommendInterest *interest, NSUInteger idx, BOOL * _Nonnull stop) {
        YARecommendInterestModel *model = [[YARecommendInterestModel alloc] init];
        // 头像
        model.icon = interest.icon;
        // 关注
        if (interest.subCount >= 1000000) {
            model.subString = [NSString stringWithFormat:@"%d万关注", (int)(interest.subCount / 10000.0)];
        } else if (interest.subCount >= 10000) {
            model.subString = [NSString stringWithFormat:@"%.1f万关注", interest.subCount / 10000.0];
        } else {
            model.subString = [NSString stringWithFormat:@"%lu关注", (unsigned long)interest.subCount];
        }
        
        // 发布
        model.pubString = [NSString stringWithFormat:@"%lu发布", (unsigned long)interest.pubCount];
        
        
        // 话题描述
        model.desc = interest.desc;
        // 话题分类
        model.catName = interest.catName;
        
        if (interest.chlname) { // 来自subList
            model.ID = interest.chlid;
            model.title = interest.chlname;
            model.isSubType = YES;
        } else { // 来自topicList
            model.ID = interest.tpid;
            model.title = interest.tpname;
            model.isSubType = NO;
        }
        
        if (index == 1) { // 热门分类,设置排名
            if (idx == 0) {
                model.hotNO = 1;
            }
            if (idx == 1) {
                model.hotNO = 2;
            }
            if (idx == 2) {
                model.hotNO = 3;
            }
        }
        
        [target addObject:model];
    }];
    return [NSArray arrayWithArray:target];
}

 #pragma mark – Getters and Setters

-  (NSDictionary *)catIDForNameDictionary {
    
    //typedef NS_ENUM(NSUInteger, YARecommendTopicType) {
    //    YARecommendTopicTypeNew = 2, // 最新
    //    YARecommendTopicTypeHot = 1, // 热门
    //    YARecommendTopicTypeInformation = 3, // 资讯
    //    YARecommendTopicTypeFinance = 4, //财经
    //    YARecommendTopicTypeTechnology, // 科技
    //    YARecommendTopicTypeLife, // 生活
    //    YARecommendTopicTypeentErtainment, // 娱乐影视
    //    YARecommendTopicTypePE, // 体育
    //    YARecommendTopicTypeGame, // 游戏动漫
    //    YARecommendTopicTypeTaste, // 趣味
    //    YARecommendTopicTypeFashion, // 时尚
    //    YARecommendTopicTypeReading, // 阅读
    //    YARecommendTopicTypeMusicDance, // 音乐舞蹈
    //    YARecommendTopicTypeEdu, // 教育
    //    YARecommendTopicTypePublicAffairs, // 公共事务
    //    YARecommendTopicTypeParenting, // 育儿
    //    YARecommendTopicTypeCar, // 汽车
    //    YARecommendTopicTypeProperty, // 房产
    //};
    return @{@"最新": @"2",
             @"热门": @"1",
             @"资讯": @"3",
             @"财经": @"4",
             @"科技": @"5",
             @"生活": @"6",
             @"娱乐影视": @"7",
             @"体育": @"8",
             @"游戏动漫": @"9",
             @"趣味": @"10",
             @"时尚": @"11",
             @"阅读": @"12",
             @"音乐舞蹈": @"13",
             @"教育": @"14",
             @"公共事务": @"15",
             @"育儿": @"16",
             @"汽车": @"17",
             @"房产": @"18",
             };
}
@end
