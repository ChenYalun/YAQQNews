//
//  YANewsCommentTableViewCell.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/13.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YANewsComment;

@interface YANewsCommentTableViewCell : UITableViewCell
/** 评论模型 */
@property (nonatomic, strong) YANewsComment *comment;
@end
