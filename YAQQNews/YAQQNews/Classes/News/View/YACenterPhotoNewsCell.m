//
//  YACenterPhotoNewsCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YACenterPhotoNewsCell.h"
#import <UIImageView+YYWebImage.h>
#import "YANewsModel.h"

@interface YACenterPhotoNewsCell ()
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
// 图标
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
// 来源
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
// 评论
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
// 图片高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoImageViewTopConstraint;
// 来源距离边界的间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceLabelLeadingConstraint;

@end


@implementation YACenterPhotoNewsCell

- (void)setNews:(YANewsModel *)news {
    _news = news;
    
    // 标题
    self.titleLabel.text = news.title;
    
    // 图片
    if (news.picShowType == NewsPicShowTypeOther) {
        self.centerImageView.hidden = YES;
        self.photoImageViewHeightConstraint.constant = 0;
        self.photoImageViewTopConstraint.constant = 5;
    } else {
        self.centerImageView.hidden = NO;
        self.photoImageViewHeightConstraint.constant = 150;
        self.photoImageViewTopConstraint.constant = 10;
        [self.centerImageView yy_setImageWithURL:[NSURL URLWithString:news.thumbnails.firstObject] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation  completion:nil];
    }
    
    
    // 图标
    if (news.iconTitle) {
        self.iconLabel.text = news.iconTitle;
        self.iconLabel.hidden = NO;
        self.sourceLabelLeadingConstraint.constant = 45;
        self.iconLabel.textColor = [UIColor colorWithHexString:news.iconColor];
        
        // 边框
        self.iconLabel.layer.borderWidth = 0.5;
        if (news.isShowIconBorder) {
            self.iconLabel.layer.borderColor = [UIColor colorWithHexString:news.iconColor].CGColor;
        } else {
            self.iconLabel.layer.borderColor = [UIColor clearColor].CGColor;
        }
        
        
    } else {
        self.iconLabel.hidden = YES;
        self.sourceLabelLeadingConstraint.constant = 15;
    }
    
    // 来源
    self.sourceLabel.text = news.source;
    
    // 评论
    if (news.isShowComment) {
        self.commentLabel.hidden = NO;
        self.commentLabel.text = news.commentText;
    } else {
        self.commentLabel.hidden = YES;
    }
    
    
    // 时间
    self.timeLabel.text = news.time;
    
   
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
