//
//  YAAppRecommendItem.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/30.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAAppRecommendItem;

/** 数据获取成功block */
typedef void(^YALoadAppRecommendItemSuccessBlock)(NSArray <YAAppRecommendItem *> * appRecommendItemList, NSString *bannerURL, NSString *bannerImage);
/** 数据获取失败block */
typedef void(^YALoadAppRecommendItemFailureBlock)(NSError *error);

@interface YAAppRecommendItem : NSObject
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** url */
@property (nonatomic, copy) NSString *url;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 图标 */
@property (nonatomic, copy) NSString *icon;

+ (void)loadAppRecommendItemAndBannerCompletionBlockWithSuccess:(YALoadAppRecommendItemSuccessBlock)success failure:(YALoadAppRecommendItemFailureBlock)failure;
@end
