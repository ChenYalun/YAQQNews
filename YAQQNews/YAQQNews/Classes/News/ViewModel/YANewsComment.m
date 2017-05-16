//
//  YANewsComment.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/13.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsComment.h"

@implementation YANewsComment

// 获取热门评论
+ (NSArray <YANewsComment *> *)hotCommentsWithObject:(id)object {
    return [YANewsComment newsCommentsWithKayValues:object[@"comments"][@"hot"]];
}

// 获取最新评论
+ (NSArray <YANewsComment *> *)newCommentsWithObject:(id)object {
    return [YANewsComment newsCommentsWithKayValues:object[@"comments"][@"new"]];
}

// 获取观点展示数据
+ (NSDictionary *)exprInfoInComments:(id)object {
    NSArray *array = object[@"exprInfo"][@"list"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in array) {
        [infoDict setValue:[NSString stringWithFormat:@"%@", dict[@"count"]] forKey:dict[@"title"]];
    }
    return infoDict;
}

// 评论数组转模型数组
+ (NSArray <YANewsComment *> *)newsCommentsWithKayValues:(NSArray *)newArray {
    
    
    NSMutableArray *comments = [NSMutableArray array];
    for (NSArray *array in newArray) {
        YANewsComment *comment = [[YANewsComment alloc] init];
    
        NSDictionary *dict = array.firstObject;
        
        if (!dict) {
            continue ;
        }
        
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
        comment.replyString = [NSString stringWithFormat:@"查看全部%lu条回复", (unsigned long)comment.replyNum];
        comment.zan = [NSString stringWithFormat:@"%@", dict[@"agree_count"]];
        // 配图
        NSArray *picArray = dict[@"pic"];
        comment.url = picArray.firstObject[@"url"];
        comment.picWidth = [picArray.firstObject[@"width"] floatValue];
        comment.picHeight = [picArray.firstObject[@"height"] floatValue];
        
        // 附加的地理位置
        NSArray *placeArray = dict[@"xy"];
        comment.place = [NSString stringWithFormat:@"%@", placeArray.firstObject[@"address"]];
        
        // 回复
        NSArray *replyArray = dict[@"reply_list"];
        // 第一条回复
        if (replyArray.firstObject) {
            NSArray *array = replyArray.firstObject;
            NSDictionary *dict = array.firstObject;
            NSString *parentName = dict[@"parent_userinfo"][@"nick"];
            NSString *currentName = dict[@"nick"];
            comment.firstContent = dict[@"reply_content"];
            
            if (parentName) {
                comment.firstName = [NSString stringWithFormat:@"%@回复%@",currentName,parentName];
            } else {
                comment.firstName = currentName;
            }
        }
        
        // 第二条回复
        if (replyArray.count >= 2) {
            NSArray *array = replyArray[1];
            NSDictionary *dict = array.firstObject;
            NSString *parentName = dict[@"parent_userinfo"][@"nick"];
            NSString *currentName = dict[@"nick"];
            comment.secondContent = dict[@"reply_content"];
            
            if (parentName) {
                comment.secondName = [NSString stringWithFormat:@"%@回复%@",currentName,parentName];
            } else {
                comment.secondName = currentName;
            }
        }
        
        [comments addObject:comment];
        
    }
    
    return comments;
}



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
