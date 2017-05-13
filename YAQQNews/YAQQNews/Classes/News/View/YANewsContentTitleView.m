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


+ (instancetype)contentTitleViewWithNews:(YANewsModel *)news {
    YANewsContentTitleView *titleView = [[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil].firstObject;
    titleView.news = news;
    return titleView;
}

- (void)setNews:(YANewsModel *)news {
    _news = news;
    

    // 标题
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.news.title];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;//行距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, news.title.length)];
    self.titleLabel.attributedText = attributedString;
    
    
    self.sourceLabel.text = news.source;
    self.dateLabel.text = news.monthDay;
    self.timeLabel.text = news.timeSecend;
    
    
    // 根据标题计算高度
    CGFloat height = [news.title boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:20]} context:nil].size.height;
    
    CGSize size = self.size;
    size.height = 42 + height;
    self.size = size;
}


@end
