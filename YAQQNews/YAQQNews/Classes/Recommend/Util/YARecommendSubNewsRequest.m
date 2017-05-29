//
//  YARecommendSubNewsRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendSubNewsRequest.h"

@interface YARecommendSubNewsRequest ()
@property (nonatomic, copy) NSString *childID;
@property (nonatomic, copy) NSString *idString;
@end
@implementation YARecommendSubNewsRequest
- (instancetype)initWithChildID:(NSString *)childID {
    if (self = [super init]) {
        _childID = childID;
    }
    return self;
}

- (instancetype)initWithNewsIdArray:(NSArray *)array {
    if (self = [super init]) {
        [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            _idString = [self.idString stringByAppendingString:[NSString stringWithFormat:@"%@,", obj]];
        }];
    }
    return self;
}

- (NSString *)requestUrl {
    if (self.childID) { // 请求新闻列表索引
        return [NSString stringWithFormat:@"http://r.inews.qq.com/getSubNewsIndex?chlid=%@", self.childID];
    } else {
        return [NSString stringWithFormat:@"http://r.inews.qq.com/getSubNewsListItems?ids=%@", self.idString];
    }
}
@end
