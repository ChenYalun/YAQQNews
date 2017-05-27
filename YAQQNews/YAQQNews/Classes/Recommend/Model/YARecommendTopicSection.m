//
//  YARecommendTopicSection.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/27.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicSection.h"
#import "YARecommendTopicModel.h"
#import <MJExtension.h>

@implementation YARecommendTopicSection
// 获取话题section数组
+ (NSArray <YARecommendTopicSection *> *)topicSectionsWithObject:(id)object {
    NSArray *array = [YARecommendTopicSection mj_objectArrayWithKeyValuesArray:object[@"data"]];
    NSMutableArray *target = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(YARecommendTopicSection *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.topicList = (NSArray *)[YARecommendTopicModel topicListWithArray:obj.topicList];
        // 剔除空数据
        if (obj.topicList.count > 0) {
            [target addObject:obj];
        }
    }];
    return target;
}
@end
