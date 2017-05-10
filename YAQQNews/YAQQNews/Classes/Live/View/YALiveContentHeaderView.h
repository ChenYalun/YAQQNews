//
//  YALiveContentHeaderView.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YALiveContent;

@interface YALiveContentHeaderView : UIView
/** 头部内容 */
@property (nonatomic, strong) YALiveContent *headContent;
+ (instancetype)liveContentHeaderView;
@end
