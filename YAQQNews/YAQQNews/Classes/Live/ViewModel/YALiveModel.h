//
//  YALiveModel.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YANewsModel;

// 直播页面流cell模型
@interface YALiveModel : NSObject

/** id数组 */
@property (nonatomic, copy) NSArray *newsIDs;
+ (NSArray<YANewsModel *> *)newsModelWithKeyValuesArray:(id)responseObject;
+ (NSArray *)newsIDsWithresponseObject:(id)responseObject;
+ (NSArray<YANewsModel *> *)newsModelWithOriginKeyValues:(id)responseObject;
@end
