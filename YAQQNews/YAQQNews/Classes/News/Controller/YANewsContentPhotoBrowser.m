//
//  YANewsContentPhotoBrowser.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/19.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContentPhotoBrowser.h"

@interface YANewsContentPhotoBrowser ()

@end

@implementation YANewsContentPhotoBrowser

- (instancetype)init {
    if (self = [super init]) {
        
        // 操作按钮
        self.displayActionButton = YES;
        // 箭头指示按钮
        self.displayArrowButton = NO;
        // 计数label
        self.displayCounterLabel = YES;
        // 完成按钮
        self.displayDoneButton = NO;
        // 点击退出浏览
        self.dismissOnTouch = YES;
        // 状态栏
        self.forceHideStatusBar = NO;

    }
    return self;
}

@end
