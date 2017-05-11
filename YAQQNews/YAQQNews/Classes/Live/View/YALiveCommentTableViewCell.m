//
//  YALiveCommentTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveCommentTableViewCell.h"
#import "YALiveComment.h"
#import <UIImageView+YYWebImage.h>
#import "UIImage+YARenderingMode.h"

@interface YALiveCommentTableViewCell ()
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
// 标志
@property (weak, nonatomic) IBOutlet UIImageView *pinImageView;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
// 内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
// 配图
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
// 回复者昵称
@property (weak, nonatomic) IBOutlet UILabel *replyNickLabel;
// 回复者内容
@property (weak, nonatomic) IBOutlet UILabel *replyContentLabel;
// 回复背景
@property (weak, nonatomic) IBOutlet UIView *replyView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyNickTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picImageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picImageWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation YALiveCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(YALiveComment *)comment {
    _comment = comment;
    
    // 昵称头像以及角色
    if (comment.role == LiveCommentRoleLive) {
        self.nickLabel.text = @"直播员";
        self.iconImageView.image = kGetImage(@"icon_role_broadcaster");
    } else if (comment.role == LiveCommentRoleCompere){
        self.iconImageView.image = kGetImage(@"icon_role_host");
        self.nickLabel.text = @"主持人";
    } else {
        self.nickLabel.text = comment.nick;
        [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:comment.head_url] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            self.iconImageView.image = [UIImage imageToRoundImageWithImage:image];
        }];
    }
    
    
    

    
    // 置顶
    if (comment.isStick) {
        self.pinImageView.hidden = NO;
        self.pinImageView.image = kGetImage(@"live_icon_pinned");
    } else if(comment.uinType){
        self.pinImageView.hidden = NO;
        self.pinImageView.image = kGetImage(@"author_choose_pinned");
    } else {
        self.pinImageView.hidden = YES;
    }
    


    
    // 内容
    self.contentLabel.text = comment.content;

    // 配图
    if (comment.url.length > 1) {
        self.picImageView.hidden = NO;
        self.picImageHeightConstraint.constant = comment.picHeight;
        self.picImageWidthConstraint.constant = comment.picWidth;
        [self.picImageView yy_setImageWithURL:[NSURL URLWithString:comment.url] options:YYWebImageOptionProgressiveBlur];
        self.replyNickTopConstraint.constant = 0;
        self.replyView.hidden = YES;
        self.replyNickTopConstraint.constant = 0;
        self.replyContentLabel.text = nil;
        self.replyNickLabel.text = nil;

    } else {
        self.picImageView.hidden = YES;
        self.picImageHeightConstraint.constant = 0.001;
        self.picImageWidthConstraint.constant = 0.001;
        // 被回复者昵称
        if (comment.replyContent) {
            self.replyView.hidden = NO;
            self.replyNickTopConstraint.constant = 6;
            self.replyContentLabel.text = comment.replyContent;
            self.replyNickLabel.text = comment.replyNick;
        } else {
            self.replyView.hidden = YES;
            self.replyNickTopConstraint.constant = 0;
            self.replyContentLabel.text = nil;
            self.replyNickLabel.text = nil;
        }
    }
    

    // 时间
    self.timeLabel.text = comment.time;
}
@end
