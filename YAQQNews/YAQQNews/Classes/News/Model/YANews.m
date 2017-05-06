//
//  YANews.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANews.h"
#import <MJExtension.h>

@implementation YANews
// 替换关键字
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}


@end


@implementation YACommentID
// 替换关键字
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}
@end
