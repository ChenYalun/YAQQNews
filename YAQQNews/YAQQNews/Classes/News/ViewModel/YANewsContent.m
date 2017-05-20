//
//  YANewsContent.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContent.h"
#import "YANewsModel.h"
#import "YANewsComment.h"
#import "YANewsContentAttribute.h"
#import "UIImage+YARenderingMode.h"

@implementation YANewsContent
+ (YANewsContent *)newsContentWithObject:(id)object news:(YANewsModel *)news{
    YANewsContent *content = [[YANewsContent alloc] init];
    // ID
    content.ID = news.ID;
    // 来源
    content.source = news.source;
    // 标题
    content.title = news.title;
    // 时间
    content.time = news.time;
    
    // 正文
    content.content =object[@"content"][@"text"];
    // FadCid
    content.FadCid = object[@"FadCid"];
    // intro
    content.intro = object[@"intro_name"];
    // 结语
    content.remarks = object[@"remarks_name"];
    // 评论标题
    content.commentTitle = object[@"commentTitle"];
    
    // 所有图片地址
    content.picURLs = [NSMutableArray array];
    
    // 图片视频
    NSMutableArray *attributeArray = [NSMutableArray array];
    
    NSDictionary *dict = object[@"attribute"];
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSArray *keyArray = [dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
        
        [keyArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
            YANewsContentAttribute *attribute = [[YANewsContentAttribute alloc] init];
            // 播放地址
            attribute.playURL = dict[key][@"playurl"];
            // 视频的vid
            attribute.vid = dict[key][@"vid"];
            // 视频时长
            attribute.duration = dict[key][@"duration"];
            // 播放数量
            attribute.playCount = [NSString stringWithFormat:@"%@", dict[key][@"playcount"]];
            // 名称
            attribute.name = key;
            // 拇指图
            attribute.thumb = dict[key][@"thumb"];
            // 描述信息
            attribute.desc = dict[key][@"desc"];
            // 宽度
            attribute.picWidth = [UIImage normalImageSizeWithOriginImageSize:CGSizeMake([dict[key][@"width"] floatValue], [dict[key][@"height"] floatValue])].width;
            // 高度
            attribute.picHeight = [UIImage normalImageSizeWithOriginImageSize:CGSizeMake([dict[key][@"width"] floatValue], [dict[key][@"height"] floatValue])].height;;
            // 图片地址
            if (dict[key][@"origUrl"]) { // 正常图片
                attribute.origUrl = dict[key][@"origUrl"];
                // 添加图片url地址
                [content.picURLs addObject:[NSURL URLWithString:attribute.origUrl]];
            } else if(dict[key][@"img"]){ // 视频
                attribute.origUrl = dict[key][@"img"];
            } else {
                attribute.picWidth = 0;
                attribute.picHeight = 0;
            }
            
            // 添加图片对象
            [attributeArray addObject:attribute];

        }];

    }
    
    content.attribute = attributeArray;
    
    
    
    NSArray *newsArray = [YANewsModel newsModelWithOriginKeyValues:object[@"relate_news"]];
    content.relateNews = [NSArray array];
    content.relateNews = newsArray;
    
    NSArray *commentArray = [YANewsContent newsShortCommentsWithKeyValues:object[@"topComments"]];
    content.topComments = [NSArray array];
    content.topComments = commentArray;
    
    return content;
}


+ (NSArray <YANewsComment *> *)newsShortCommentsWithKeyValues:(NSArray *)newArray {
    // 最新评论
    NSMutableArray *comments = [NSMutableArray array];
    for (NSArray *array in newArray) {
        NSDictionary *dict = array.firstObject;
        YANewsComment *comment = [[YANewsComment alloc] init];
        comment.head_url = dict[@"head_url"];
        comment.nick = dict[@"nick"];
        comment.content = dict[@"reply_content"];
        comment.agreeCount = [dict[@"agree_count"] integerValue];
        comment.time = [YANewsContent setUpTime:[dict[@"pub_time"] floatValue]];
        comment.replyNum = [dict[@"reply_num"] integerValue];
        comment.attributeText = [NSString stringWithFormat:@"%lu回复 · %lu赞 · %@",(unsigned long)comment.replyNum, (unsigned long)comment.agreeCount, comment.time];
        
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
