//
//  YAChannelViewController.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YANewsModel.h"

@interface YAChannelViewController : UIViewController
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 复用的控制器 */
- (instancetype)initWithViewControllerType:(YAViewControllerType)viewControllerType;
@end
