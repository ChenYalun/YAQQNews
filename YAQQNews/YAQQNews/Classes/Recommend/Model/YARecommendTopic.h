//
//  YARecommendTopic.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/27.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YARecommendTopic : NSObject
/** topicID */
@property (nonatomic, copy) NSString *tpid;
/** 话题名称 */
@property (nonatomic, copy) NSString *tpname;
/** 话题描述 */
@property (nonatomic, copy) NSString *desc;
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 话题分类 */
@property (nonatomic, copy) NSString *catName;
/** 时间戳 */
@property (nonatomic, copy) NSString *lastArtUpdate;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 订阅数量 */
@property (nonatomic, assign) NSUInteger subCount;
/** 更新周 */
@property (nonatomic, assign) NSUInteger updateWeek;
/** 索引*/
@property (nonatomic, assign) NSUInteger index;

@end
