//
//  YAChannelRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

typedef NS_OPTIONS(NSUInteger, RequestChannelOptions) {
    RequestChannelOptionsVideo = 1 << 0,
    RequestChannelOptionsFinance = 1 << 1,
    RequestChannelOptionsSports = 1 << 2,
    RequestChannelOptionsEnt = 1 << 3,
};

@interface YAChannelRequest : YTKRequest

/** 以page形式加载新内容 */
@property (nonatomic, strong) NSNumber *page;
/** 频道类型 */
@property (nonatomic, assign) RequestChannelOptions channelType;
// 初始化方法
- (instancetype)initWithChannel:(RequestChannelOptions)channel page:(NSNumber *)page;
@end
