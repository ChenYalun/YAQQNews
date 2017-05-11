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
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *replyNickLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyContentLabel;
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
    
    // 昵称
    self.nickLabel.text = comment.nick;
    
    // 头像
   [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:comment.head_url] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
       self.iconImageView.image = [UIImage imageToRoundImageWithImage:image];
    }];


    
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
