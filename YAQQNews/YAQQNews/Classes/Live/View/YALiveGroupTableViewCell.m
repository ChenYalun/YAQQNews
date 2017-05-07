//
//  YALiveGroupTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveGroupTableViewCell.h"
#import "YANewsModel.h"
#import <UIImageView+YYWebImage.h>

@interface YALiveGroupTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@end

@implementation YALiveGroupTableViewCell

- (void)setNews:(YANewsModel *)news {
    _news = news;
    
    self.titleLabel.text = news.specialDataTitle;
   
    self.subTitleLabel.text = news.specialDataSubTitle;
    
    self.descriptionLabel.text = news.specialDataNumText;
    
    [self.newsImageView yy_setImageWithURL:[NSURL URLWithString:news.thumbnails.firstObject] placeholder:nil options:YYWebImageOptionProgressiveBlur  completion:nil];
}
@end
