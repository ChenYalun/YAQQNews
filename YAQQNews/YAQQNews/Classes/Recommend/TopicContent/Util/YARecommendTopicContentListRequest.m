//
//  YANewsRecommendTopicContentListRequest.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicContentListRequest.h"

@interface YARecommendTopicContentListRequest ()
@property (nonatomic, copy) NSString *topicID;
@property (nonatomic, copy) NSString *idString;
@end
@implementation YARecommendTopicContentListRequest
- (instancetype)initWithCategoryID:(NSString *)topicID newsList:(NSArray *)ids {
    if (self = [super init]) {
        _topicID = topicID;
        _idString = [NSString string];
        
        [ids enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            _idString = [self.idString stringByAppendingString:[NSString stringWithFormat:@"%@,", obj]];
        }];

    }
    return self;
}


- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"http://r.inews.qq.com/getTopicNewsIndex?tpid=%@&ids=%@",self.topicID, self.idString];

}
@end
