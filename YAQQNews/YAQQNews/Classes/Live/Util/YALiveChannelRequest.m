//
//  YALiveChannelRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveChannelRequest.h"
#import "YANewsModel.h"

@interface YALiveChannelRequest ()
/** 请求频道类型 */
@property (nonatomic, assign) LiveChannelType channelType;
@end

@implementation YALiveChannelRequest

- (instancetype)initWithChannelType:(LiveChannelType)channel {
    if (self = [super init]) {
        _channelType = channel;
    }
    return self;
}

// 请求URL
- (NSString *)requestUrl {
    return @"http://r.inews.qq.com/getLiveNewsIndexAndItems";
}

// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 请求参数
- (id)requestArgument {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *type = [NSString string];
    
    switch (self.channelType) {
        case LiveChannelTypeMain:
            type = @"news_live_main";
            break;
        case LiveChannelTypeInfo:
            type = @"news_live_info";
            break;
        case LiveChannelTypeArt:
            type = @"news_live_art";
            break;
        case LiveChannelTypeEnt:
            type = @"news_live_ent";
            break;
        case LiveChannelTypeFinance:
            type = @"news_live_finance";
            break;
        case LiveChannelTypeTV:
            type = @"news_live_tv";
            break;
        case LiveChannelTypeSports:
            type = @"news_live_sports";
            break;
        case LiveChannelTypeMSJ:
            type = @"news_live_msj";
            break;
        case LiveChannelTypeLifes:
            type = @"news_live_lifes";
            break;
    }
    
    
    [dict setObject:type forKey:@"chlid"];
    return dict;
}
@end
