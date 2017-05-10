//
//  YACommentTableViewCell.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YALiveComment;

@interface YACommentTableViewCell : UITableViewCell
/** 评论模型 */
@property (nonatomic, strong) YALiveComment *comment;
@end
