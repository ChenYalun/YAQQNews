//
//  YARecommendInterestModel.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YARecommendInterestModel;

/** 数据获取成功block */
typedef void(^YALoadInterestNewsListSuccessBlock)(NSArray <YARecommendInterestModel *> *interestList);
/** 数据获取失败block */
typedef void(^YALoadInterestNewsListFailureBlock)(NSError *error);

@interface YARecommendInterestModel : NSObject

// 映射字典
@property (nonatomic, copy, readonly) NSDictionary *catIDForNameDictionary;
/** 订阅数量 */
@property (nonatomic, copy) NSString *subString;
/** 发布数量 */
@property (nonatomic, copy) NSString *pubString;
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 话题描述 */
@property (nonatomic, copy) NSString *desc;
/** 话题分类 */
@property (nonatomic, copy) NSString *catName;
/** subList,需要加认证,且为圆头像 */
@property (nonatomic, assign) BOOL isSubType;
/** child */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *title;

/** 热门分类中的排名 */
@property (nonatomic, assign) NSUInteger hotNO;

+ (NSArray <NSString *> *)loadTitleListWithObject:(id)object;
+ (NSArray <YARecommendInterestModel *> *)loadInterestWithObject:(id)object index:(NSUInteger)index;
+ (void)loadMoreInterestWithPage:(NSUInteger)page catID:(NSString *)catID  completionBlockWithSuccess:(YALoadInterestNewsListSuccessBlock)success failure:(YALoadInterestNewsListFailureBlock)failure;
@end
