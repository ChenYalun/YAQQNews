//
//  YALiveContent.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveContent.h"
#import "YALiveComment.h"
#import "YANewsModel.h"

static CGFloat const kMaxPicHeight = 270.0;

@implementation YALiveContent
+ (YALiveContent *)liveContentWithKeyValue:(id)responseObject {
    YALiveContent *content = [[YALiveContent alloc] init];
    
    // 根据rose_intro判断是关于类型还是主播类型
    if (responseObject[@"rose_intro"]) { // 主播类型
        
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
        for (YALiveComment *comment in aArray) {
            comment.isStick = YES;
        }
        // new数组
        NSArray *bArray = [YALiveContent getCommentsFromObject:responseObject[@"content"][@"live_room"][@"new"]];
        // 评论模型
        content.comments = [aArray arrayByAddingObjectsFromArray:bArray];
    
       
    } else { // 关于类型

        content.playurl = responseObject[@"videos"][@"live"][@"playurl"];
        content.videoImage = responseObject[@"videos"][@"live"][@"img"];
        
        // 相关新闻
        content.relateNews = [YANewsModel newsModelWithOriginKeyValues:responseObject[@"relate_news"]];
        
        // 栏目简介
        content.desc = responseObject[@"desc"];
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
        
        // 时间处理
        CGFloat time = [dict[@"pub_time"] floatValue];
        comment.time = [YALiveContent setUpTime:time];
        
        // 评论ID("rose_40039017_6375702;pic;pic;")需要裁剪
        NSString *commentID = dict[@"rose_data"][@"id"];
        comment.ID = [commentID componentsSeparatedByString:@";"].firstObject;
        
        // 角色
        comment.role = [dict[@"rose_data"][@"role"] integerValue];
        
        // 字典转模型
        id object = dict[@"rose_data"][@"attachment"];
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)object;
            [YALiveContent setUpComment:comment withObject:array.firstObject];
            [comments addObject:comment];
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            [YALiveContent setUpComment:comment withObject:object];
            [comments addObject:comment];
        }
        
        
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

// 针对不同评论json的处理

+ (void)setUpComment:(YALiveComment *)comment withObject:(id)object {
    comment.url = object[@"url"];
    comment.replyNick = object[@"nick"];
    comment.replyContent = object[@"reply_content"];
    comment.playURL = object[@"playurl"];
    comment.uinType = object[@"uin_type"];
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

}
@end
