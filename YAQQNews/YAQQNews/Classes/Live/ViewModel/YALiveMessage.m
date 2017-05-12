//
//  YALiveMessage.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveMessage.h"
#import "NSDate+YADateFormater.h"

@implementation YALiveMessage

// 主播页面字典转模型
+ (NSArray <YALiveMessage *> *)liveMessageWithObject:(id)object {
    NSArray *objectArray = object[@"content"][@"comments"][@"comments"];
    NSMutableArray *messageArray = [NSMutableArray array];
    for (NSArray *array in objectArray) {
        
        if (array.count == 2) { // 有艾特的情况
            NSDictionary *firstDict = array.firstObject;
            NSDictionary *secondDict = array[1];
            YALiveMessage *message = [YALiveMessage liveMessageWithKeyValue:secondDict];
            message.replyNick = [NSString stringWithFormat:@"@%@", firstDict[@"nick"]];
            [messageArray addObject:message];
        } else { // 没有艾特别人
            YALiveMessage *message = [YALiveMessage liveMessageWithKeyValue:array.firstObject];
            [messageArray addObject:message];
        }

    }
    
    return messageArray;
}

// 关于页面字典转模型
+ (NSArray <YALiveMessage *> *)liveMessageWithKeyValues:(id)object {
    NSMutableArray *messageArray = [NSMutableArray array];
    
    NSArray *array = object[@"comments"][@"barrage"];
    for (NSDictionary *mainDict in array) {
        YALiveMessage *message = [[YALiveMessage alloc] init];
        message.replyID = mainDict[@"reply_id"];
        message.nick = mainDict[@"nick"];
        message.content = mainDict[@"reply_content"];
        message.head_url = mainDict[@"head_url"];
        
        [messageArray addObject:message];
    }
    return messageArray;
}


 #pragma mark – Private Methods
 // 字典转模型
+ (YALiveMessage *)liveMessageWithKeyValue:(NSDictionary *)mainDict {
    YALiveMessage *message = [[YALiveMessage alloc] init];
    
    // 图片
    NSArray *picArray = mainDict[@"pic"];
    if (picArray) {
        message.url = picArray.firstObject[@"url"];
        message.picWidth = [picArray.firstObject[@"width"] floatValue] * 0.5;
        message.picHeight = [picArray.firstObject[@"height"] floatValue] * 0.5;
    }
    
    
    message.nick = mainDict[@"nick"];
    message.content = mainDict[@"reply_content"];
    message.head_url = mainDict[@"head_url"];
    
    // 时间处理
    message.time = [YALiveMessage setUpTime:[mainDict[@"pub_time"] floatValue]];
    message.replyID = mainDict[@"reply_id"];
    
    return message;
}

// 时间处理
+ (NSString *)setUpTime:(CGFloat)time {
    NSString *timeString = [NSString string];
    
    CGFloat referenceTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    
    if ((referenceTime - time) / 60 == 0) {
        timeString = @"刚刚";
    } else if ((referenceTime - time) / 60 < 60) {
        timeString = [NSString stringWithFormat:@"%ld分钟前", (long)((referenceTime - time) / 60)];
    } else if((referenceTime - time) / 3600 < 24 ) {
        timeString = [NSString stringWithFormat:@"%ld小时前", (long)((referenceTime - time) / 3600)];
    } else if((referenceTime - time) / 3600 < 24 * 5 ){
        NSString *string = [NSDate ya_ISO8601String:[NSDate dateWithTimeIntervalSince1970:time]];
        timeString = [NSString stringWithFormat:@"%@月%@日", [string substringWithRange:NSMakeRange(5, 2)], [string substringWithRange:NSMakeRange(8, 2)]];
    } else {
        timeString = nil;
    }
    return timeString;
}

@end
