//
//  YARecommendTopicContentHeader.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YARecommendTopicContentHeader : NSObject
/** 描述信息 */
@property (nonatomic, copy) NSString *desc;
/** 图片 */
@property (nonatomic, copy) NSString *icon;
/** 时间戳 */
@property (nonatomic, assign) NSUInteger lastArtUpdate;
/** 发布数量 */
@property (nonatomic, copy) NSString *pubString;
/** 订阅数量 */
@property (nonatomic, copy) NSString *subString;
/** 分类ID */
@property (nonatomic, copy) NSString *catId;
/** 话题ID */
@property (nonatomic, copy) NSString *tpid;
/** 话题标题 */
@property (nonatomic, copy) NSString *tpname;

// 字典转模型
+ (void)setUpTopicContentHeaderWithTopicID:(NSString *)topicID titleLabel:(UILabel *)titleLabel headerTitleLabel:(UILabel *)headerTitleLabel descLabel:(UILabel *)descLabel subLabel:(UILabel *)subLabel pubLabel:(UILabel *)pubLabel backImageView:(UIImageView *)backImageView;
@end
