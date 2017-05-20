//
//  YAProfileDetail.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAProfileDetail : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 描述 */
@property (nonatomic, copy) NSString *desc;

// 获取数据
+ (NSArray <YAProfileDetail *> *)profileDetail;
@end
