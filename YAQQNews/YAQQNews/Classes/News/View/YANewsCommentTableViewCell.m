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
@property (weak, nonatomic) IBOutlet UILabel *replyContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picImageViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyBottomConstraint;

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
    if (comment.zan) {
        self.zanNumLabel.text = comment.zan;
        self.zanButton.hidden = NO;
        self.zanNumLabel.hidden = NO;
    } else {
        self.zanButton.hidden = YES;
        self.zanNumLabel.hidden = YES;
    }
    
    // 内容
    self.contentLabel.text = comment.content;
    
    // 图片
    if (comment.url) {
        self.picImageView.hidden = NO;
         self.picImageViewHeightConstraint.constant = [UIImage normalImageSizeWithOriginImageSize:CGSizeMake(comment.picWidth, comment.picHeight)].height;
        self.picImageViewWidthConstraint.constant = [UIImage normalImageSizeWithOriginImageSize:CGSizeMake(comment.picWidth, comment.picHeight)].width - 30;
        [self.picImageView yy_setImageWithURL:[NSURL URLWithString:comment.url] options:YYWebImageOptionSetImageWithFadeAnimation];
    } else {
        self.picImageView.hidden = YES;
        self.picImageViewHeightConstraint.constant = 0;
        self.picImageViewWidthConstraint.constant = 0;
    }
    
    // 来源
    if (comment.provinceCity.length > 2 && comment.time) {
        self.sourceLabel.text = [NSString stringWithFormat:@"%@ · %@",comment.provinceCity, comment.time];
    } else {
        self.sourceLabel.text = nil;
    }
    
    
    // 地点
    if (comment.place.length > 5) {
        self.placeLabel.text = comment.place;
        self.placeIconImageView.hidden = NO;
    } else {
        self.placeLabel.text = nil;
        self.placeIconImageView.hidden = YES;
    }
    
    // 附加评论回复
    if (comment.replyNum > 0) {
        self.replyTopConstraint.constant = 13;
        self.replyBottomConstraint.constant = 11;
        self.backView.hidden = NO;
        self.replyContentLabel.hidden = NO;
        self.replyContentLabel.text = comment.firstContent ? comment.firstContent : comment.replyString;
    } else {
        self.replyContentLabel.text = nil;
        self.replyContentLabel.hidden = YES;
        self.backView.hidden = YES;
        self.replyTopConstraint.constant = 0;
        self.replyBottomConstraint.constant = 8;
    }

    
}
- (IBAction)like:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
