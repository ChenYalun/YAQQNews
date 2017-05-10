
//  YALiveNewsListRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/8.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "YANewsModel.h"

// 根据直播ids获取新闻cell
@interface YALiveNewsListRequest : YTKRequest
- (instancetype)initWithChannelType:(LiveChannelType)channel ids:(NSArray *)ids;
@end
