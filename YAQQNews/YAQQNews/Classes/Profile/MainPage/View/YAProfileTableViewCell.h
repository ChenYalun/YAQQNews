//
//  YAProfileTableViewCell.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YAProfileDetail;

@interface YAProfileTableViewCell : UITableViewCell
/** 模型 */
@property (nonatomic, strong) YAProfileDetail *detail;
@end
