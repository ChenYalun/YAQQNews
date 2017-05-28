//
//  YARecommendTopicContentHeaderRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

typedef NS_ENUM(NSUInteger, YARecommendTopicType) {
    YARecommendTopicTypeNew, // 最新
    YARecommendTopicTypeHot, // 热门
    YARecommendTopicTypeInformation, // 资讯
    YARecommendTopicTypeFinance, //财经
    YARecommendTopicTypeTechnology, // 科技
    YARecommendTopicTypeLife, // 生活
    YARecommendTopicTypeentErtainment, // 娱乐影视
    YARecommendTopicTypePE, // 体育
    YARecommendTopicTypeGame, // 游戏动漫
    YARecommendTopicTypeTaste, // 趣味
    YARecommendTopicTypeFashion, // 时尚
    YARecommendTopicTypeReading, // 阅读
    YARecommendTopicTypeMusicDance, // 音乐舞蹈
    YARecommendTopicTypeEdu, // 教育
    YARecommendTopicTypePublicAffairs, // 公共事务
    YARecommendTopicTypeParenting, // 育儿
    YARecommendTopicTypeCar, // 汽车
    YARecommendTopicTypeProperty, // 房产
};

@interface YARecommendTopicContentHeaderRequest : YTKRequest
// 初始化方法
- (instancetype)initWithTopicID:(NSString *)topicID;
@end
