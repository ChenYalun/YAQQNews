//
//  YALiveComment.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YALiveComment : NSObject;
/** 评论者昵称 */
@property (nonatomic, copy) NSString *nick;
/** 评论者头像 */
@property (nonatomic, copy) NSString *head_url;
/** 评论配图 */
@property (nonatomic, copy) NSString *url;
/** 评论时间 */
@property (nonatomic, copy) NSString *time;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 图片高度 */
@property (nonatomic, assign) CGFloat picHeight;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat picWidth;
/** 被回复者昵称 */
@property (nonatomic, copy) NSString *replyNick;
/** 被回复者评论内容 */
@property (nonatomic, copy) NSString *replyContent;
@end

