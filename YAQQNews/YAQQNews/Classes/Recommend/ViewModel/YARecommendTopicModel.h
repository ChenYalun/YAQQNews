//
//  YARecommendTopicModel.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/27.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YARecommendTopicSection;

@interface YARecommendTopicModel : NSObject
/** topicID */
@property (nonatomic, copy) NSString *topicPid;
/** 话题名称 */
@property (nonatomic, copy) NSString *topicPname;
/** 话题描述 */
@property (nonatomic, copy) NSString *desc;
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 话题分类 */
@property (nonatomic, copy) NSString *catName;
/** 时间戳 */
@property (nonatomic, copy) NSString *dateString;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 订阅数量 */
@property (nonatomic, copy) NSString *subCountString;
/** 更新周 */
@property (nonatomic, assign) NSUInteger updateWeek;
/** 索引*/
@property (nonatomic, assign) NSUInteger index;

+ (NSMutableArray <YARecommendTopicModel *> *)topicListWithArray:(NSArray *)sourceArray;
@end
