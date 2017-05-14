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
    
    // 图片视频
//    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
//    NSDictionary *dict = object[@"attribute"];
//    NSArray *keyArray = dict.allKeys;
//    for (NSString *key in keyArray) {
//        NSString *playURL = key[@"playurl"];
//        NSString *desc = key
//    }
    content.attribute = object[@"attribute"];
    
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
        comment.attributeText = @"18回复 · 22赞  18分钟前";
        
        [comments addObject:comment];
    }
    
    return comments;
}
@end
