//
//  YANews.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

// 直播频道类型
typedef NS_ENUM(NSUInteger,LiveChannelType) {
    LiveChannelTypeMain, // 精选
    LiveChannelTypeInfo, // 资讯
    LiveChannelTypeArt, // 文艺
    LiveChannelTypeEnt, // 娱乐
    LiveChannelTypeFinance,  // 财经
    LiveChannelTypeTV, // 电视台
    LiveChannelTypeSports, // 体育
    LiveChannelTypeMSJ,  // 慢视界
    LiveChannelTypeLifes // 生活
};

// icon类型
typedef NS_ENUM(NSUInteger, NewsArticleType) {
    NewsArticleTypeNormal = 0, // 普通新闻
    NewsArticleTypePicture = 1, // 图片浏览
    NewsArticleTypeTopic = 100, // 专题
    NewsArticleTypeVideo = 101, // 视频
    NewsArticleTypeSingleLive = 102, // 单个直播,主播厅 万人
    NewsArticleTypeAboutLive = 110, // 单个直播,关于 人
    NewsArticleTypeGroupLive = 113, // 直播组
    NewsArticleTypeImportant = 524 // 要闻必读
    
    // 直播中的110 不知道什么类型,但是 是单条直播
    
};


// 图片展示类型
typedef NS_ENUM(NSUInteger, NewsPicShowType) {
    NewsPicShowTypeRightPhoto,
    NewsPicShowTypeOther
};

/*
 
 labelList": [
 {
 "type": 1,
 "color": "#ff1479D7",
 "nightColor": "#ff0f63b2",
 "word": "置顶",
 "border": 0,
 "displayMode": 0,
 "focusDisplayMode": 0
 }
 */

//
// 图标模型
//@interface YAIconLabel : NSObject
//* 类型 
//@property (nonatomic, assign) NSUInteger type;
//* 颜色 
//@property (nonatomic, copy) NSString *color;
//* 夜间颜色 
//@property (nonatomic, copy) NSString *nightColor;
//* 文字 
//@property (nonatomic, copy) NSString *word;
//* 边框 
//@property (nonatomic, assign) BOOL border;
//@end


// 评论ID模型
@interface YACommentID : NSObject
/** 文章对应的评论ID */
@property (nonatomic, copy) NSString *ID;
/** 文字对应的评论数量 */
@property (nonatomic, strong) NSNumber *comments;
@end



// 新闻模型
@interface YANews : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 是否显示来源 */
@property (nonatomic, assign) BOOL show_source;
/** 来源 */
@property (nonatomic, copy) NSString *source;

/** 是否禁止删除功能 */
@property (nonatomic, assign) BOOL disableDelete;

/** 是否显示评论数量 */
@property (nonatomic, assign) BOOL openAdsComment;
/** 文章对应的评论ID */
@property (nonatomic, copy) NSString *commentid;

/** 文章id */
@property (nonatomic, copy) NSString *ID;
/** 时间 */
@property (nonatomic, copy) NSString *time;
/** 图片数组 */
@property (nonatomic, strong) NSArray *thumbnails_qqnews;
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
@property (nonatomic, assign) BOOL is_live;
/** 直播主题描述 */
@property (nonatomic, copy) NSDictionary *specialData;
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
//@property (nonatomic,assign) BOOL stick;

/** 图标 */
@property (nonatomic, copy) NSArray *labelList;

@end



