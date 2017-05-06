//
//  YANetWork.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface YANetWork : NSObject
/** 网络状态 */
@property (nonatomic, copy) NSString *networkStatus;
/** 设备ID */
@property (nonatomic, copy) NSString *devid;

+ (instancetype)sharedmanager;
@end
