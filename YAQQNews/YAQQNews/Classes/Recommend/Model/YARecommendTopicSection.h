//
//  YARecommendTopicSection.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/27.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YARecommendTopicModel;

@interface YARecommendTopicSection : NSObject
/** 话题类目 */
@property (nonatomic, copy) NSString *catID;
/** 话题名称 */
@property (nonatomic, copy) NSString *catName;
/** 话题列表 */
@property (nonatomic, strong) NSArray <YARecommendTopicModel *> *topicList;

+ (NSArray <YARecommendTopicSection *> *)topicSectionsWithObject:(id)object;
@end
