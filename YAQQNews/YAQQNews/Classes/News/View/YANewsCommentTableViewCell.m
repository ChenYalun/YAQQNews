//
//  YANewsCommentTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/13.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsCommentTableViewCell.h"
#import <UIImageView+YYWebImage.h>
#import "YANewsComment.h"
#import "UIImage+YARenderingMode.h"

@interface YANewsCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreInfoLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picImageViewHeightConstraint;

@end
@implementation YANewsCommentTableViewCell

 #pragma mark – Getters and Setters

-(void)setComment:(YANewsComment *)comment {
    _comment = comment;
    
    // 标题
    self.nickLabel.text = comment.nick;
    // 头像
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:comment.head_url] placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        self.iconImageView.image = [UIImage imageToRoundImageWithImage:image];
        
    }];
    // 点赞
    self.zanNumLabel.text = comment.zan;
    // 内容
    self.contentLabel.text = comment.content;
    
    // 图片
    if (comment.url) {
        self.picImageView.hidden = NO;
         self.picImageViewHeightConstraint.constant = 58;
        [self.picImageView yy_setImageWithURL:[NSURL URLWithString:comment.url] options:YYWebImageOptionSetImageWithFadeAnimation];
    } else {
        self.picImageView.hidden = YES;
        self.picImageViewHeightConstraint.constant = 0;
    }
    
    // 来源
    self.sourceLabel.text = comment.provinceCity;
    
    // 地点
    if (comment.place) {
        self.placeLabel.text = comment.place;
        self.placeIconImageView.hidden = NO;
    } else {
        self.placeLabel.text = nil;
        self.placeIconImageView.hidden = YES;
    }
    
    // 附加评论回复
    if (comment.firstName) {
        self.firstNameLabel.hidden = NO;
        self.firstContentLabel.hidden = NO;
        self.firstNameLabel.text = comment.firstName;
        self.firstContentLabel.text = comment.firstContent;
    } else {
        self.firstContentLabel.text = nil;
        self.firstNameLabel.text = nil;
        self.firstNameLabel.hidden = YES;
        self.firstContentLabel.hidden = YES;
    }
    
    if (comment.secondName) {
        self.secondNameLabel.hidden = NO;
        self.secondContentLabel.hidden = NO;
        self.secondNameLabel.text = comment.secondName;
        self.secondContentLabel.text = comment.secondContent;
    } else {
        self.secondContentLabel.text = nil;
        self.secondNameLabel.text = nil;
        self.secondNameLabel.hidden = YES;
        self.secondContentLabel.hidden = YES;
    }
    
    // 查看更多内容
    self.moreInfoLabel.text = comment.replyString;
    
}
- (IBAction)like:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
