//
//  YANetWork.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANetWork.h"

static YANetWork *network = nil;

@interface YANetWork ()

@end


@implementation YANetWork


- (NSString *)networkStatus {
    
    NSString *status = [NSString string];

    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            status = @"wifi";
            break;
        case AFNetworkReachabilityStatusUnknown:
            status =  @"wifi";
            break;
            
#warning network 需要修改
        case AFNetworkReachabilityStatusReachableViaWWAN:
            status =  @"wifi";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            status =  @"wifi";
            break;
        default:
            status =  @"wifi";
    }
    
    return status;
}

- (NSString *)devid {
    return @"F9074E18-E12A-4E15-8F98-0B7C114653FB";
}


 #pragma mark – Life Cycle

+ (instancetype)sharedmanager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[YANetWork alloc] init];
    });
    
    return network;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (network == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            network = [super allocWithZone:zone];
        });
    }
    return network;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [super init];
    });
    return network;
}

@end
