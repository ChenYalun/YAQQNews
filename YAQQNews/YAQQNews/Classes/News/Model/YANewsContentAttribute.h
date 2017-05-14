//
//  YANewsContentAttribute.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/14.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YANewsContentAttribute : NSObject
/** 对应的名称 */
@property (nonatomic, copy) NSString *name;
/** 播放地址 */
@property (nonatomic, copy) NSString *playURL;
/** 视频的vid */
@property (nonatomic, copy) NSString *vid;
/** 视频时长 */
@property (nonatomic, copy) NSString *duration;
/** 播放数量 */
@property (nonatomic, copy) NSString *playCount;
/** 图片地址 */
@property (nonatomic, copy) NSString *origUrl;
/** 拇指图 */
@property (nonatomic, copy) NSString *thumb;
/** 描述信息 */
@property (nonatomic, copy) NSString *desc;
/** 元素对应的y值 */
@property (nonatomic, assign) CGFloat offsetY;
/** 是否已经替换过图片 */
@property (nonatomic, assign) BOOL hasReplaced;
@end
