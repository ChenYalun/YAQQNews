//
//  YANewsModel.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YANews.h"

@interface YANewsModel : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 是否显示来源 */
@property (nonatomic, assign) BOOL isShowSource;
/** 来源 */
@property (nonatomic, copy) NSString *source;

/** 是否禁止删除功能 */
@property (nonatomic, assign) BOOL isShowDelete;

/** 是否显示评论数量 */
@property (nonatomic, assign) BOOL isShowComment;
/** 评论内容 */
@property (nonatomic, copy) NSString *commentText;
/** 文章对应的评论ID */
@property (nonatomic, copy) NSString *commentid;

/** 文章id */
@property (nonatomic, copy) NSString *ID;
/** 时间 */
@property (nonatomic, copy) NSString *time;
/** 月日 */
@property (nonatomic, copy) NSString *monthDay;
/** 时分 */
@property (nonatomic, copy) NSString *timeSecend;
/** 图片数组 */
@property (nonatomic, strong) NSArray *thumbnails;
/** 时间戳 */
@property (nonatomic, copy) NSString *timestamp;
/** 图片类型 */
@property (nonatomic, assign) NewsPicShowType picShowType;
/** 文章类型 */
@property (nonatomic, assign) NewsArticleType articletype;
/** 视频时间 */
@property (nonatomic, copy) NSString *videoTotalTime;

/** 图片浏览类型的图片数量 */
@property (nonatomic, assign) NSUInteger imagecount;

/** 正在直播 */
@property (nonatomic, assign) BOOL isLive;
/** 直播主题描述标题 */
@property (nonatomic, copy) NSString *specialDataTitle;
/** 直播主题描述前缀 */
@property (nonatomic, copy) NSString *specialDataSubTitle;
/** 直播主题描述数量 */
@property (nonatomic, copy) NSString *specialDataNumText;
/*
 fixed_pos_list": [
 {
 "a_ver": "03",
 "id": "NEW2017050601032900",
 "fixed_pos": 1,
 "fixed_pos_2": 0,
 "stick": 1
 }
 ],
 
 
 */
/** 置顶 */
@property (nonatomic,assign) BOOL stick;
/** 图标颜色 */
@property (nonatomic, copy) NSString *iconColor;
/** 图标文字 */
@property (nonatomic, copy) NSString *iconTitle;
/** 图标边框 */
@property (nonatomic, assign) BOOL isShowIconBorder;

+ (NSArray<YANewsModel *> *)newsModelWithKeyValuesArray:(id)responseObject;

+ (NSArray <YANewsModel *> *)newsModelWithOriginKeyValues:(NSArray *)keyValues;
@end
