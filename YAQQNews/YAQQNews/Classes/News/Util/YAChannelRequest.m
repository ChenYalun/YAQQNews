//
//  YAChannelRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAChannelRequest.h"
#import "YANetWork.h"

@implementation YAChannelRequest

- (instancetype)initWithChannel:(RequestChannelOptions)channel page:(NSNumber *)page {
    if (self = [super init]) {
        _page = page;
        _channelType = channel;
    }
    return self;
}

// 请求URL
- (NSString *)requestUrl {
    NSString *type = [NSString string];
    
    if (self.channelType & RequestChannelOptionsVideo) {
        type = [type stringByAppendingString:@"&user_chlid=news_video_top"];
    }
    
    if (self.channelType & RequestChannelOptionsFinance) {
         type = [type stringByAppendingString:@"&user_chlid=news_news_finance"];
    }
    
    if (self.channelType & RequestChannelOptionsSports) {
         type = [type stringByAppendingString:@"&user_chlid=news_news_sports"];
    }
    
    if (self.channelType & RequestChannelOptionsEnt) {
         type = [type stringByAppendingString:@"&user_chlid=news_news_ent"];
    }

    
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getQQNewsUnreadList?network_type=%@&devid=%@%@", [YANetWork sharedmanager].networkStatus, [YANetWork sharedmanager].devid, type];
}

// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 请求参数
- (id)requestArgument {

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.page forKey:@"page"];
    
    return dict;
}
@end
