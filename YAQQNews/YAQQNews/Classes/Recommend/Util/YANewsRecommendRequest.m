//
//  YANewsRecommendRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsRecommendRequest.h"
#import "YANetWork.h"

@implementation YANewsRecommendRequest

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getRecommendList?devid=%@",[YANetWork sharedmanager].devid];
}

@end
