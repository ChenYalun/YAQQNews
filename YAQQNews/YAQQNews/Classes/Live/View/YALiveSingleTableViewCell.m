//
//  YALiveSingleTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveSingleTableViewCell.h"
#import <UIImageView+YYWebImage.h>
#import "YANewsModel.h"

@interface YALiveSingleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconPersonImageView;
@property (weak, nonatomic) IBOutlet UILabel *iconPersonLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconZanImageView;
@property (weak, nonatomic) IBOutlet UILabel *iconZanLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconPersonLeadingConstraint;


@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation YALiveSingleTableViewCell

- (void)setNews:(YANewsModel *)news {
    _news = news;
    
     [self.newsImageView yy_setImageWithURL:[NSURL URLWithString:news.thumbnails.firstObject] placeholder:nil options:YYWebImageOptionProgressiveBlur  completion:nil];
    
    self.sourceLabel.text = news.source;
    self.timeLabel.text = news.time;
    
    self.titleLabel.text = news.title;
    
    if (news.isLive) {
        self.liveImageView.hidden = NO;
        self.iconPersonLeadingConstraint.constant = 10 + self.liveImageView.width;
    } else {
        self.liveImageView.hidden = YES;
        self.iconPersonLeadingConstraint.constant = 0 ;
    }
}

@end
