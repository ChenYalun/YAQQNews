//
//  YAAppRecommendTableViewCell.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/30.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YAAppRecommendItem;

@interface YAAppRecommendTableViewCell : UITableViewCell
/** 数据模型 */
@property (nonatomic, strong) YAAppRecommendItem *item;
@end
