//
//  YANavigationView.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YANavigationView : UIView
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 隐藏菜单按钮 */
@property (nonatomic, assign) BOOL hiddenMenuButton;
+ (instancetype)navigationView;
@end
