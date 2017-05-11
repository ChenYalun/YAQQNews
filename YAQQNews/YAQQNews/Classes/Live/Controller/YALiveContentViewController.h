//
//  YALiveContentViewController.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YANewsModel.h"

@interface YALiveContentViewController : UIViewController
/** 新闻模型 */
@property (nonatomic, strong) YANewsModel *news;
- (instancetype)initWithNews:(YANewsModel *)news;
@end
