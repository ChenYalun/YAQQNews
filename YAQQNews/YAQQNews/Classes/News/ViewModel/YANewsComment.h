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
/** 附加属性 */
@property (nonatomic, copy) NSString *attributeText;


@end
