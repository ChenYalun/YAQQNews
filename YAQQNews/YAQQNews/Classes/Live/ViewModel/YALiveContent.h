//
//  YALiveContent.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YALiveComment;

@interface YALiveContent : NSObject
/** 播放地址 */
@property (nonatomic, copy) NSString *playurl;
/** 图片展示 */
@property (nonatomic, copy) NSString *videoImage;
/** 在线人数 */
@property (nonatomic, copy) NSString *onlineNumber;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 屏幕类型 */
@property (nonatomic, assign) BOOL screenType;
/** 评论数组 */
@property (nonatomic, copy) NSArray <YALiveComment *> *comments;
+ (YALiveContent *)liveContentWithKeyValue:(id)responseObject;
@end
