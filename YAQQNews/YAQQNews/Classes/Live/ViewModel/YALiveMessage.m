//
//  YALiveMessage.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveMessage.h"

@implementation YALiveMessage
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

 #pragma mark – Private Methods
 // 字典转模型
+ (YALiveMessage *)liveMessageWithKeyValue:(NSDictionary *)mainDict {
    YALiveMessage *message = [[YALiveMessage alloc] init];
    
    // 图片
    NSArray *picArray = mainDict[@"pic"];
    if (picArray) {
        message.url = picArray.firstObject[@"url"];
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            message.url = @"http://puep.qpic.cn/coral/Q3auHgzwzM7VT5bujZJC69Zmxqtxg71AicVVa2ZTABTAfsr7M8aibbgA/500";
        });
        message.picWidth = [picArray.firstObject[@"width"] floatValue] * 0.5;
        message.picHeight = [picArray.firstObject[@"height"] floatValue] * 0.5;
    }
    
    
    message.nick = mainDict[@"nick"];
    message.content = mainDict[@"reply_content"];
    message.head_url = mainDict[@"head_url"];
    
    // 时间处理
    message.time = mainDict[@"pub_time"];
    message.time = @"5月8日";
    
    message.replyID = mainDict[@"reply_id"];
    
    return message;
}
@end
