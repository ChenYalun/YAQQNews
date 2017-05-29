//
//  YARecommendInterest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YARecommendInterest : NSObject
// 公有部分
/** 订阅数量 */
@property (nonatomic, assign) NSUInteger subCount;
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 话题描述 */
@property (nonatomic, copy) NSString *desc;
/** 话题分类 */
@property (nonatomic, copy) NSString *catName;


// subList,需要加认证,且为圆头像
/** child */
@property (nonatomic, copy) NSString *chlid;
/** 名称 */
@property (nonatomic, copy) NSString *chlname;
/** 发布数量 */
@property (nonatomic, assign) NSUInteger pubCount;

// topicList,不加认证,方头像
/** topicID */
@property (nonatomic, copy) NSString *tpid;
/** 话题名称 */
@property (nonatomic, copy) NSString *tpname;

@end
