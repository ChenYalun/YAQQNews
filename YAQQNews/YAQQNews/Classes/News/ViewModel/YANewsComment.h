//
//  YANewsComment.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/13.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveComment.h"

@interface YANewsComment : YALiveComment
/** vip描述 */
@property (nonatomic, copy) NSString *vipDesc;
/** vip类型 */
@property (nonatomic, assign) NSUInteger vipType;
/** 回复数量 */
@property (nonatomic, assign) NSUInteger replyNum;
/** 回复数量合成的内容 */
@property (nonatomic, copy) NSString *replyString;
/** 附加的地理位置 */
@property (nonatomic, copy) NSString *place;
/** 附加整合信息 */
@property (nonatomic, copy) NSString *attributeText;
/** 点赞数量 */
@property (nonatomic, copy) NSString *zan;

// 附加的两条回复
/** 昵称 */
@property (nonatomic, copy) NSString *firstName;
/** 内容 */
@property (nonatomic, copy) NSString *firstContent;
/** 昵称 */
@property (nonatomic, copy) NSString *secondName;
/** 内容 */
@property (nonatomic, copy) NSString *secondContent;


// 获取热门评论
+ (NSArray <YANewsComment *> *)hotCommentsWithObject:(id)object;

// 获取最新评论
+ (NSArray <YANewsComment *> *)newCommentsWithObject:(id)object;

// 获取观点展示数据
+ (NSDictionary *)exprInfoInComments:(id)object;
@end
