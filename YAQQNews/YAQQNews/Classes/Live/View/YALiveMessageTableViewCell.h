//
//  YALiveMessageTableViewCell.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YALiveMessage;

@interface YALiveMessageTableViewCell : UITableViewCell
/** message模型 */
@property (nonatomic, strong) YALiveMessage *message;
@end
