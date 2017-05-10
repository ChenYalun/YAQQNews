//
//  YALiveContent.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveContent.h"
#import "YALiveComment.h"

static CGFloat const kMaxPicHeight = 270.0;

@implementation YALiveContent
+ (YALiveContent *)liveContentWithKeyValue:(id)responseObject {
    YALiveContent *content = [[YALiveContent alloc] init];
    
    // 根据rose_intro判断是关于类型还是主播类型
    if (responseObject[@"rose_intro"]) { // 主播类型
        content.title = responseObject[@"title"];
        
        NSArray *roseVideo = responseObject[@"rose_video"];
        if (roseVideo) {
            content.playurl = roseVideo.firstObject[@"playurl"];
            content.videoImage = roseVideo.firstObject[@"img"];
        }
        
        // 在线数量
        NSNumber *onlibeNum = responseObject[@"update_info"][@"online_total"];
        content.onlineNumber = [NSString stringWithFormat:@"%@", onlibeNum];
        
        // top数组
        NSArray *aArray = [YALiveContent getCommentsFromObject:responseObject[@"content"][@"live_room"][@"top"]];
        // new数组
        NSArray *bArray = [YALiveContent getCommentsFromObject:responseObject[@"content"][@"live_room"][@"new"]];
        // 评论模型
        content.comments = [aArray arrayByAddingObjectsFromArray:bArray];
    
        
       
    } else { // 关于类型
        content.title = responseObject[@"desc"];
        content.playurl = responseObject[@"videos"][@"live"][@"playurl"];
        content.videoImage = responseObject[@"videos"][@"live"][@"img"];
        content.screenType = responseObject[@"videos"][@"live"][@"screenType"];
    }
    
    
    return content;
}

// 获取评论模型数组
+ (NSArray *)getCommentsFromObject:(NSArray *)array {
    // 评论数组
    NSMutableArray <YALiveComment *> *comments = [NSMutableArray array];
    
    for (NSArray *bArray in array) {
        YALiveComment *comment = [[YALiveComment alloc] init];
        NSDictionary *dict = bArray.firstObject;
        comment.content = dict[@"reply_content"];
        comment.nick = dict[@"nick"];
        comment.head_url = dict[@"head_url"];
        
        // 时间
        NSString *timeString = [NSString string];
        CGFloat time = [dict[@"pub_time"] floatValue];
        CGFloat referenceTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
        if ((referenceTime - time) / 60 < 60) {
            timeString = [NSString stringWithFormat:@"%ld分钟前", (long)((referenceTime - time) / 60)];
        } else if((referenceTime - time) / 60 < 3600) {
            timeString = [NSString stringWithFormat:@"%ld小时前", (long)((referenceTime - time) / 3600)];
        } else {
            timeString = nil;
        }
        
        comment.time = timeString;
        
        
        id object = dict[@"rose_data"][@"attachment"];
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)object;
            comment.url = array.firstObject[@"url"];
            comment.replyNick = array.firstObject[@"nick"];
            comment.replyContent = array.firstObject[@"reply_content"];
            CGFloat height = [array.firstObject[@"height"] floatValue];
            CGFloat width = [array.firstObject[@"width"] floatValue];
            if (width < kScreenWidth - 50) {
                comment.picWidth = width * 0.6;
                comment.picHeight = height < kMaxPicHeight ? height : kMaxPicHeight;
            } else {
                height = height * (kScreenWidth - 50) / width;
                width = (kScreenWidth - 50);
                comment.picWidth = width;
                comment.picHeight = height < kMaxPicHeight ? height : kMaxPicHeight;
            }
            // 最大高度
            comment.picHeight = height < kMaxPicHeight ? height : kMaxPicHeight;
            [comments addObject:comment];
            
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            comment.url = object[@"url"];
            comment.replyNick = object[@"nick"];
            comment.replyContent = object[@"reply_content"];
            CGFloat height = [object[@"height"] floatValue];
            CGFloat width = [object[@"width"] floatValue];
            if (width < kScreenWidth - 50) {
                comment.picWidth = width * 0.6;
                comment.picHeight = height < kMaxPicHeight ? height : kMaxPicHeight;
            } else {
                height = height * (kScreenWidth - 50) / width;
                width = (kScreenWidth - 50);
                comment.picWidth = width;
                comment.picHeight = height < kMaxPicHeight ? height : kMaxPicHeight;
            }
            // 最大高度
            comment.picHeight = height < kMaxPicHeight ? height : kMaxPicHeight;
            [comments addObject:comment];
        }
    }
    
    return comments;
}
@end
