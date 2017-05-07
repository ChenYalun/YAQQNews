//
//  YALiveModel.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveModel.h"
#import "YANewsModel.h"

@implementation YALiveModel

+ (NSArray<YANewsModel *> *)newsModelWithKeyValuesArray:(id)responseObject {
    NSArray *array = responseObject[@"idlist"];
    
    // 新闻模型
    NSArray *models = [YANewsModel newsModelWithOriginKeyValues:array.firstObject[@"newslist"]];
    
    return models;
}

+ (NSArray *)newsIDsWithresponseObject:(id)responseObject {
    NSArray *array = responseObject[@"idlist"];
    
    // 新闻id数组
    NSMutableArray *ids = [NSMutableArray array];
    NSArray *idDictList = array.firstObject[@"ids"];
    for (NSDictionary *idDict in idDictList) {
        [ids addObject:idDict[@"id"]];
    }
    return ids;
}
@end
