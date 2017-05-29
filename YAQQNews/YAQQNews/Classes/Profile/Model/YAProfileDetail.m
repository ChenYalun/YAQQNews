//
//  YAProfileDetail.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAProfileDetail.h"

@implementation YAProfileDetail

+ (NSArray <YAProfileDetail *> *)profileDetail {

    YAProfileDetail *message = [[YAProfileDetail alloc] init];
    message.title = @"我的消息";
    
    YAProfileDetail *sub = [[YAProfileDetail alloc] init];
    sub.title = @"我的关注";
    
    YAProfileDetail *collection = [[YAProfileDetail alloc] init];
    collection.title = @"我的收藏";
    
    YAProfileDetail *comment = [[YAProfileDetail alloc] init];
    comment.title = @"我的评论";
    
    YAProfileDetail *packet = [[YAProfileDetail alloc] init];
    packet.title = @"红包";
    packet.urlString = @"https://view.inews.qq.com/bonus?isnm=1";
    packet.desc = @"邀请好友得现金红包";
    
    YAProfileDetail *advice = [[YAProfileDetail alloc] init];
    advice.title = @"投诉建议";
    
    YAProfileDetail *game = [[YAProfileDetail alloc] init];
    game.title = @"游戏";
    game.urlString = @"http://iwan.qq.com/m/qqnews/hotgames.htm?isnm=1";

    return @[message, sub, collection, comment, packet, advice, game];
}
@end
