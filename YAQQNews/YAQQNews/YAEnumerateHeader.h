//
//  YAEnumerateHeader.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/8.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#ifndef YAEnumerateHeader_h
#define YAEnumerateHeader_h

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
    NewsArticleTypeSingleLive = 102, // 单个直播
    NewsArticleTypeGroupLive = 113, // 直播组
    NewsArticleTypeImportant = 524 // 要闻必读
    
    // 直播中的110 不知道什么类型,但是 是单条直播
    
};

// 图片展示类型
typedef NS_ENUM(NSUInteger, NewsPicShowType) {
    NewsPicShowTypeRightPhoto,
    NewsPicShowTypeOther
};


#endif /* YAEnumerateHeader_h */
