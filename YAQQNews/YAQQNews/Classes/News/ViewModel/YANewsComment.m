//
//  YANewsComment.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/13.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsComment.h"

@implementation YANewsComment
/*
+ (NSArray <YANewsComment *> *)newsCommentsWithObject:(id)object {

    // 热门评论
    
    
    // 最新评论
    NSArray *newArray = object[@"comments"][@"new"];
    NSMutableArray *newComments = [NSMutableArray array];
    for (NSArray *array in newArray) {
        YANewsComment *comment = [[YANewsComment alloc] init];
        
        if (array.count >= 2) { // 包含回复
            
        } else { // 不包含回复
            NSDictionary *dict = array.firstObject;
            comment.agreeCount = [dict[@"agree_count"] integerValue];
            comment.head_url = dict[@"head_url"];
            comment.nick = dict[@"nick"];
            comment.provinceCity = dict[@"province_city"];
            comment.time = [YANewsComment setUpTime:[dict[@"pub_time"] floatValue]];
            comment.content = dict[@"reply_content"];
            comment.ID = dict[@"reply_id"];
            comment.vipDesc = dict[@"vip_desc"];
            comment.vipType = [dict[@"vip_type"] integerValue];
            comment.replyNum = [dict[@"reply_num"] integerValue];
            
        }
    }
}

 */

// 时间处理
+ (NSString *)setUpTime:(CGFloat)time {
    NSString *timeString = [NSString string];
    
    CGFloat referenceTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    
    if ((referenceTime - time) / 60 == 0) {
        timeString = @"刚刚";
    } else if ((referenceTime - time) / 60 < 60) {
        timeString = [NSString stringWithFormat:@"%ld分钟前", (long)((referenceTime - time) / 60)];
    } else if((referenceTime - time) / 60 < 3600) {
        timeString = [NSString stringWithFormat:@"%ld小时前", (long)((referenceTime - time) / 3600)];
    } else {
        timeString = nil;
    }
    return timeString;
}
@end
