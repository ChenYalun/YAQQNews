//
//  YALiveNewsListRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/8.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveNewsListRequest.h"
#import "YAEnumerateHeader.h"

@interface YALiveNewsListRequest ()
/** 请求频道类型 */
@property (nonatomic, assign) LiveChannelType channelType;
/** id数组 */
@property (nonatomic, copy) NSArray <NSString *> *ids;
@end
@implementation YALiveNewsListRequest
- (instancetype)initWithChannelType:(LiveChannelType)channel ids:(NSArray *)ids{
    if (self = [super init]) {
        _channelType = channel;
        _ids = ids;
    }
    return self;
}

// 请求URL
- (NSString *)requestUrl {

    return @"http://r.inews.qq.com/getLiveNewsListItems";
}

// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 请求参数
- (id)requestArgument {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // 类型
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
    
    // id参数
    NSString *arguement = [NSString string];
    for (NSString *url in self.ids) {
        arguement = [arguement stringByAppendingString:[NSString stringWithFormat:@"%@,", url]];
    }
    
    [dict setObject:arguement forKey:@"ids"];
    [dict setObject:type forKey:@"chlid"];
    return dict;
}

@end
