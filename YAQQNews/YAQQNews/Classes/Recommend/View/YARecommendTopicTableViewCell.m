//
//  YARecommendTopicTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/27.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicTableViewCell.h"
#import <UIImageView+YYWebImage.h>
#import "YARecommendTopicModel.h"

@interface YARecommendTopicTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *catNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation YARecommendTopicTableViewCell

- (void)setTopic:(YARecommendTopicModel *)topic {
    _topic = topic;
    
    // 图片
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:topic.icon] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    // 标题
    self.titleLabel.text = topic.topicPname;
    
    // 频道
    self.catNameLabel.text = topic.catName;
    
    self.subLabel.text = topic.subCountString;
    
    // 日期
    if (topic.dateString) {
        self.dateLabel.hidden = NO;
        self.dateLabel.text = topic.dateString;
    } else {
        self.dateLabel.hidden = YES;
    }
    
    
}

// 订阅该话题
- (IBAction)subForTopic:(UIButton *)sender {
}
@end
