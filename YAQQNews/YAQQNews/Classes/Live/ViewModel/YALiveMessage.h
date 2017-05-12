//
//  YALiveMessage.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YALiveMessage : NSObject
/** message者昵称 */
@property (nonatomic, copy) NSString *nick;
/** message者头像 */
@property (nonatomic, copy) NSString *head_url;
/** message配图 */
@property (nonatomic, copy) NSString *url;
/** message时间 */
@property (nonatomic, copy) NSString *time;
/** message内容 */
@property (nonatomic, copy) NSString *content;
/** 图片高度 */
@property (nonatomic, assign) CGFloat picHeight;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat picWidth;
/** 被艾特的昵称 */
@property (nonatomic, copy) NSString *replyNick;
/** messageID */
@property (nonatomic, copy) NSString *replyID;

+ (NSMutableArray <YALiveMessage *> *)liveMessageWithObject:(id)object;

+ (NSArray <YALiveMessage *> *)liveMessageWithKeyValues:(id)object;
@end
