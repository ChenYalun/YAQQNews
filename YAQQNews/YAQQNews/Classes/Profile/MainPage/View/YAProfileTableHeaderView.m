//
//  YAProfileTableHeaderView.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAProfileTableHeaderView.h"

@implementation YAProfileTableHeaderView
+ (instancetype)profileTableHeaderView {
    YAProfileTableHeaderView *view = [[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil].firstObject;
    view.height = 60;
    return view;
}
@end
