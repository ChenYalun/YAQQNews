//
//  YALiveChannelViewController.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YANewsModel.h"

@interface YALiveChannelViewController : UITableViewController
/** 请求频道 */
@property (nonatomic, assign) LiveChannelType channelType;
// 重写init方法
- (instancetype)initWithChannelType:(LiveChannelType)type;
@end
