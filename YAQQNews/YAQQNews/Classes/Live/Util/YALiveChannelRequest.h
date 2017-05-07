//
//  YALiveChannelRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

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

@interface YALiveChannelRequest : YTKRequest


- (instancetype)initWithChannelType:(LiveChannelType)channel;
@end
