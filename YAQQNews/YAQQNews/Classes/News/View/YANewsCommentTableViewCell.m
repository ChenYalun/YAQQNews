//
//  YANewsCommentTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/13.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsCommentTableViewCell.h"

@interface YANewsCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;

@end
@implementation YANewsCommentTableViewCell

 #pragma mark – Getters and Setters

-(void)setComment:(YANewsComment *)comment {
    _comment = comment;
    
    
}
- (IBAction)like:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
