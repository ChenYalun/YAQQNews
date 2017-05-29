//
//  YARecommendInterestListRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendInterestListRequest.h"

@interface YARecommendInterestListRequest ()
@property (nonatomic, copy) NSString *catID;
@property (nonatomic, assign) NSUInteger page;
@end
@implementation YARecommendInterestListRequest

- (instancetype)initWithRefreshPage:(NSUInteger)page catID:(NSString *)catID {
    if (self = [super init]) {
        _page = page;
        _catID = catID;
    }
    return self;
}
- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getCatSubAndTopic?refresh=%lu&catid=%@", (unsigned long)self.page, self.catID];
}
@end
