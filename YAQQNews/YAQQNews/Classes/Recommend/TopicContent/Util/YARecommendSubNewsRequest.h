//
//  YARecommendSubNewsRequest.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface YARecommendSubNewsRequest : YTKRequest
- (instancetype)initWithChildID:(NSString *)childID;
- (instancetype)initWithNewsIdArray:(NSArray *)array;
@end
