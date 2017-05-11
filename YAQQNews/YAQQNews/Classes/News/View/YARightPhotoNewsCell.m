//
//  YARightPhotoNewsCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARightPhotoNewsCell.h"
#import "YANewsModel.h"
#import <UIImageView+YYWebImage.h>

static const CGFloat kTitleBottomConstraint = 34.5;
static const CGFloat kTitleTopConstraint = 10;

@interface YARightPhotoNewsCell ()
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
// 图标
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
// 来源
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
// 评论
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

// 标题距离底部的高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;
// 来源距离边界的间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceLabelLeadingConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;


@end
@implementation YARightPhotoNewsCell

- (void)setNews:(YANewsModel *)news {
    _news = news;
    
    // 标题
    self.titleLabel.text = news.title;
    

    // 是否直播
    if (news.isLive) {
        self.liveImageView.hidden = NO;
    } else {
        self.liveImageView.hidden = YES;
    }
    // 图标
    if (news.iconTitle) {
        UIFont *font = [UIFont systemFontOfSize:10];
        CGFloat width = [news.iconTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{ NSFontAttributeName : font }
                                                        context:nil].size.width;
        
        self.iconLabel.text = news.iconTitle;
        self.iconLabel.hidden = NO;
        self.sourceLabelLeadingConstraint.constant = 20 + width;
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
        self.iconLabel.text = nil;
        self.sourceLabelLeadingConstraint.constant = 15;
    }
    
    
    // 来源
    if (news.isShowSource) {
        self.sourceLabel.hidden = NO;
        self.sourceLabel.text = news.source;
    } else {
        self.sourceLabel.hidden = YES;
        self.sourceLabel.text = nil;
    }
    
    // 评论
    if (news.isShowComment) {
        self.commentLabel.text = news.commentText;
        self.commentLabel.hidden = NO;
    } else {
        self.commentLabel.text = nil;
        self.commentLabel.hidden = YES;
    }
   
    // 时间
    self.timeLabel.text = news.time;
    
    // 视频
    if (news.videoTotalTime) {
        self.videoImageView.hidden = NO;
    } else {
        self.videoImageView.hidden = YES;
    }
    
    // 图片
    [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:news.thumbnails.firstObject] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    
    // 单行标题调整
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect suggestedRect = [news.title boundingRectWithSize:CGSizeMake(kScreenWidth - 145, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName : font }
                                              context:nil];
    
    // 计算单行文本高度
    CGSize linesize = [news.title sizeWithAttributes:@{
                                             NSFontAttributeName : font
                                             }];
 
    CGFloat textHeight = suggestedRect.size.height;
    CGFloat lineHeight = linesize.height;
    
    
    if (textHeight <= lineHeight) {
        self.titleBottomConstraint.constant = 40;
        self.titleTopConstraint.constant = 20;
    } else {
        self.titleBottomConstraint.constant = kTitleBottomConstraint;
        self.titleTopConstraint.constant = kTitleTopConstraint;
    }
    
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
