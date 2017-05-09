//
//  YALiveChannelRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "YANewsModel.h"

// 根据直播频道刷新直播列表
@interface YALiveChannelRequest : YTKRequest

- (instancetype)initWithChannelType:(LiveChannelType)channel;
@end
