//
//  YALiveComment.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveComment.h"
#import "YALiveContent.h"

@implementation YALiveComment
+ (NSArray <YALiveComment *> *)liveCommentWithObject:(id)object {
    NSArray *array = [YALiveContent getCommentsFromObject:object[@"content"][@"live_room"][@"new"]];
    return array;
}
@end
