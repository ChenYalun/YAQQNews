//
//  YARecommendTopicModel.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/27.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicModel.h"
#import "YARecommendTopic.h"
#import <MJExtension.h>
#import "YARecommendTopicSection.h"
#import <MJExtension.h>
#import "NSDate+YADateFormater.h"

@implementation YARecommendTopicModel

// topic字典数组转模型数组
+ (NSMutableArray <YARecommendTopicModel *> *)topicListWithArray:(NSArray *)sourceArray {
    NSArray <YARecommendTopic *> *topicArray = [YARecommendTopic mj_objectArrayWithKeyValuesArray:sourceArray];
    
    NSMutableArray *array = [NSMutableArray array];
    for (YARecommendTopic *topic in topicArray) {
        YARecommendTopicModel *model = [[YARecommendTopicModel alloc] init];
        model.topicPid = topic.tpid;
        model.topicPname = topic.tpname;
        model.desc = topic.desc;
        model.icon = topic.icon;
        model.catName = topic.catName;
        model.title = topic.title;
        
        // 关注人数处理
        if (topic.subCount >= 10000) {
            CGFloat count = topic.subCount / 10000.0;
            model.subCountString = [NSString stringWithFormat:@"%.2f万关注",count];
        } else {
            model.subCountString = [NSString stringWithFormat:@"%lu关注",(unsigned long)topic.subCount];
        }
        
        // 日期处理
        if (topic.lastArtUpdate) {
            model.dateString = [YARecommendTopicModel setUpTime:topic.lastArtUpdate.floatValue];
        }
        model.updateWeek = topic.updateWeek;
        model.index = topic.index;
        

        [array addObject:model];
        
        
    }
    return array;
}

// 时间处理
+ (NSString *)setUpTime:(CGFloat)time {
    NSString *timeString = [NSString string];
    
    CGFloat referenceTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    
    if ((referenceTime - time) / 60 == 0) {
        timeString = @"刚刚";
    } else if ((referenceTime - time) / 60 < 60) {
        timeString = [NSString stringWithFormat:@"%ld分钟前", (long)((referenceTime - time) / 60)];
    } else if((referenceTime - time) / 3600 < 24 ) {
        timeString = [NSString stringWithFormat:@"%ld小时前", (long)((referenceTime - time) / 3600)];
    } else if((referenceTime - time) / 3600 < 24 * 2 ){
        timeString = @"昨天";
    } else if((referenceTime - time) / 3600 < 24 * 3 ){
        timeString = @"前天";
    } else {
        NSString *string = [NSDate ya_ISO8601String:[NSDate dateWithTimeIntervalSince1970:time]];
        timeString = [NSString stringWithFormat:@"%@月%@日", [string substringWithRange:NSMakeRange(5, 2)], [string substringWithRange:NSMakeRange(8, 2)]];
    }
    return timeString;
}

@end
