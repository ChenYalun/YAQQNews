//
//  YALiveContent.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YALiveComment, YANewsModel;

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
/** 相关新闻数组 */
@property (nonatomic, strong) NSArray <YANewsModel *> *relateNews;
/** 栏目简介 */
@property (nonatomic, copy) NSString *desc;
// 获取内容模型
+ (YALiveContent *)liveContentWithKeyValue:(id)responseObject;

// 获取评论模型数组
+ (NSArray *)getCommentsFromObject:(NSArray *)array;


@end
