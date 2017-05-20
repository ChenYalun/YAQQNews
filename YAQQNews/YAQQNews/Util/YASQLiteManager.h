//
//  YASQLiteManager.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface YASQLiteManager : NSObject
+ (instancetype)sharedManager;

/** 操作队列 */
@property (nonatomic,strong) FMDatabaseQueue *queue;
@end
