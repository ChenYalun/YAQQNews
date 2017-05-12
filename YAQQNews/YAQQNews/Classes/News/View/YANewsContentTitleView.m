//
//  YANewsContentTitleView.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContentTitleView.h"
#import "YANewsModel.h"

@interface YANewsContentTitleView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/** 新闻 */
@property (nonatomic, strong) YANewsModel *news;
@end
@implementation YANewsContentTitleView



- (instancetype)initWithNews:(YANewsModel *)news {
    _news = news;
    
    YANewsContentTitleView *titleView = [[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil].firstObject;
    titleView.news = news;
    return titleView;
}

- (void)setNews:(YANewsModel *)news {
    _news = news;
    
    self.titleLabel.text = self.news.title;
    self.sourceLabel.text = self.news.source;
    self.dateLabel.text = @"05-12";
    self.timeLabel.text = @"16:20";
}

@end
