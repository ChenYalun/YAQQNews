//
//  YANewsContent.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContent.h"
#import "YANewsModel.h"
#import "YALiveComment.h"

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
    [content.relateNews addObjectsFromArray:newsArray];
    
    NSArray *commentArray = [YALiveComment commentsFromKeyValus:object[@"topComments"]];
    [content.topComments addObjectsFromArray:commentArray];
    
    return content;
}
@end
