//
//  YALiveMessageTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveMessageTableViewCell.h"
#import "YALiveMessage.h"
#import <UIImageView+YYWebImage.h>
#import "UIImage+YARenderingMode.h"


@interface YALiveMessageTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

// 气泡宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewWidthConstraint;
// 内容宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelWidthConstraint;
// 图片距离气泡底部的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picImageViewBottomConstraint;
// 图片高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picImageViewHeightConstraint;

@end
@implementation YALiveMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.contentView.transform = CGAffineTransformMakeScale(1, -1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMessage:(YALiveMessage *)message {
    _message = message;
    
    // 昵称
    self.nickLabel.text = message.nick;
    // 头像
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:message.head_url] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        self.iconImageView.image = [UIImage imageToRoundImageWithImage:image];
    }];
    // 时间
    self.timeLabel.text = message.time;
    // 内容
    self.contentLabel.text = message.content;
    
    // 根据内容长度确定气泡和文本内容宽度
    CGSize contentSize = [message.content sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    if (contentSize.width < 130) {
        self.backViewWidthConstraint.constant = 140;
        self.contentLabelWidthConstraint.constant = 130;
    } else if (contentSize.width < kScreenWidth - 100){
        self.backViewWidthConstraint.constant = contentSize.width;
        self.contentLabelWidthConstraint.constant = contentSize.width - 10;
    } else {
        self.backViewWidthConstraint.constant = kScreenWidth - 100;
        self.contentLabelWidthConstraint.constant = kScreenWidth - 110 - 5;
    }
    
    // 图片
    if (message.url.length > 1) {
        [self.picImageView yy_setImageWithURL:[NSURL URLWithString:message.url] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
        self.picImageViewHeightConstraint.constant = 50;
        self.picImageViewBottomConstraint.constant = 5;
        self.picImageView.hidden = NO;
    } else {
        self.picImageViewHeightConstraint.constant = 0;
        self.picImageViewBottomConstraint.constant = 0;
        self.picImageView.hidden = YES;
    }
}
@end
