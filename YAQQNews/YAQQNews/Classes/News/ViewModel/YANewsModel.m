//
//  YANewsModel.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsModel.h"
#import "NSDate+YADateFormater.h"
#import <MJExtension.h>

@implementation YANewsModel

// 根据传进来的请求结果进行字典转模型
+ (NSArray<YANewsModel *> *)newsModelWithKeyValuesArray:(id)responseObject {
    // 保存文章id对应的评论数量
    NSMutableDictionary *commentDict = [NSMutableDictionary dictionary];
    
    // 评论数量的获取
    NSArray *commentIDArray = [YACommentID mj_objectArrayWithKeyValuesArray:responseObject[@"ids"]];
    for (YACommentID *commentID in commentIDArray) {
        [commentDict setValue:commentID.comments forKey:commentID.ID];
    }
    
    // 保存文章id对应的评论数量
    NSMutableDictionary *stickDict = [NSMutableDictionary dictionary];
    
    // 置顶新闻的获取
    NSArray *stickNews = responseObject[@"fixed_pos_list"];
    for (id news in stickNews) {
        [stickDict setValue:@1 forKey:news[@"id"]];
    }
    
    // 新闻模型
    NSArray *newsArray = [YANews mj_objectArrayWithKeyValuesArray:responseObject[@"newslist"]];
    NSMutableArray *models = [NSMutableArray array];
    for (YANews * news in newsArray) {
        YANewsModel *model = [[YANewsModel alloc] init];
        
        // 新闻标题
        model.title = news.title;
        
        // 新闻来源
        model.isShowSource = news.show_source;
        if (news.source.length > 8) {
            model.source = [NSString stringWithFormat:@"%@...",[news.source substringToIndex:8]];
        } else {
            model.source = news.source;
        }
        
        
        // ID
        model.ID = news.ID;
        
        // 拇指图
        model.thumbnails = news.thumbnails_qqnews;
        
        // 时间戳
        model.timestamp = news.timestamp;
        
        // 月份/分钟
        NSString *timeString = [NSDate ya_ISO8601String:[NSDate dateWithTimeIntervalSince1970:[news.timestamp floatValue]]];
        
        model.monthDay = [timeString substringWithRange:NSMakeRange(5, 5)];
        
        model.timeSecend = [timeString substringWithRange:NSMakeRange(11, 5)];

        // 视频时长
        if (news.videoTotalTime.length > 3) {
            model.videoTotalTime = [news.videoTotalTime substringFromIndex:3];
        }
        
        
        // 评论
        model.commentid = news.commentid;
        model.isShowComment = news.openAdsComment;
        NSNumber *commentCount = commentDict[news.ID];
        if ([commentCount integerValue] > 0) {
            model.commentText = [NSString stringWithFormat:@"%@评", commentCount];
        }
        
        
        // 时间处理
        model.time = [YANewsModel setupCreatedTime:news.time];
        
        
        // 图片展示类型
        model.picShowType = news.picShowType;
        
        // icon处理
        if (news.labelList.count > 0) {
            model.iconColor = news.labelList.firstObject[@"color"];
            model.iconTitle = news.labelList.firstObject[@"word"];
            
         
            
//            model.iconTitle = model.iconLabel.word;
//            model.iconColor = model.iconLabel.color;
//            model.isShowIconBorder = model.iconLabel.border;
            
            
        }
       
        
        // 置顶
        model.stick = [stickDict[news.ID] integerValue];
        
        if (model.stick) {
            [models insertObject:model atIndex:0];
        } else {
            [models addObject:model];
        }
        
    }
    return models;
}


// 根据字典数组转化为模型数组
+ (NSArray <YANewsModel *> *)newsModelWithOriginKeyValues:(NSArray *)keyValues {
    
    // 新闻模型
    NSArray *newsArray = [YANews mj_objectArrayWithKeyValuesArray:keyValues];
    NSMutableArray *models = [NSMutableArray array];
    for (YANews * news in newsArray) {
        YANewsModel *model = [[YANewsModel alloc] init];
        
        // 新闻标题
        model.title = news.title;
        
        // 新闻来源
        model.isShowSource = news.show_source;
        model.source = news.source;
        
        // 新闻类型
        model.articletype = news.articletype;
        
        // ID
        model.ID = news.ID;
        
        // 拇指图
        model.thumbnails = news.thumbnails_qqnews;
        
        // 时间戳
        model.timestamp = news.timestamp;
        
        // 月份/分钟
        NSString *timeString = [NSDate ya_ISO8601String:[NSDate dateWithTimeIntervalSince1970:[news.timestamp floatValue]]];
        
        model.monthDay = [timeString substringWithRange:NSMakeRange(5, 5)];
        
        model.timeSecend = [timeString substringWithRange:NSMakeRange(11, 5)];
        
        // 视频时长
        if (news.videoTotalTime.length > 3) {
            model.videoTotalTime = [news.videoTotalTime substringFromIndex:3];
        }
        
        
        // 直播
        model.isLive = news.is_live;
        
        // 直播描述
        if (news.specialData) {
            model.specialDataTitle = news.specialData[@"ztTitle"];
            
            model.specialDataSubTitle = [NSString stringWithFormat:@"%@：%@", news.specialData[@"titlePre"], news.title];
                        model.specialDataNumText = [NSString stringWithFormat:@"共%ld场直播 >", [news.specialData[@"liveNum"] unsignedIntegerValue]];
            
        }

        // 评论
        model.commentid = news.commentid;
        
        // 时间处理
        model.time = [YANewsModel setupCreatedTime:news.time];
        
        // 图片展示类型
        model.picShowType = news.picShowType;
        
        // icon处理
        if (news.labelList.count > 0) {
            model.iconColor = news.labelList.firstObject[@"color"];
            model.iconTitle = news.labelList.firstObject[@"word"];
            
        }
        
        [models addObject:model];
    }
    return models;

}
// 处理时间
+ (NSString *)setupCreatedTime:(NSString *)timeString {
    
    NSDate *date = [NSDate ya_dateFromISO8601StringDateFormatter:timeString locale:[NSLocale currentLocale]];
    
    NSInteger timeinterval = fabs(round([[NSDate date] timeIntervalSinceDate:date]));
    
    if (timeinterval < 3600) {
        return [NSString stringWithFormat:@"%ld分钟前",(long)timeinterval / 60];
    } else {
        return nil;
    };
}


@end
