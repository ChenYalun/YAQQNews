//
//  YANewsShortCommentTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/13.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsShortCommentTableViewCell.h"
#import "YANewsComment.h"
#import <UIImageView+YYWebImage.h>
#import "UIImage+YARenderingMode.h"

@interface YANewsShortCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *attributeLabel;

@end
@implementation YANewsShortCommentTableViewCell

- (void)setComment:(YANewsComment *)comment {
    _comment = comment;
    
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:comment.head_url] placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        self.iconImageView.image = [UIImage imageToRoundImageWithImage:image];
        
    }];
    
    self.nickLabel.text = comment.nick;
    
    self.contentLabel.text = comment.content;
    
    self.attributeLabel.text = comment.attributeText;
}

@end
