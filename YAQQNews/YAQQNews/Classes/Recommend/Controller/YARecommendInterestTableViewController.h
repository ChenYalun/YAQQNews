//
//  YARecommendInterestTableViewController.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YARecommendInterestModel;

@interface YARecommendInterestTableViewController : UITableViewController
- (instancetype)initWithInterestModelArray:(NSArray <YARecommendInterestModel *> *)array;
@end
