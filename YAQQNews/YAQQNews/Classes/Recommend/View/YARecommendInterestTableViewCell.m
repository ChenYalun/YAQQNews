//
//  YARecommendInterestTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendInterestTableViewCell.h"
#import <UIImageView+YYWebImage.h>
#import "YARecommendInterestModel.h"
#import "UIImage+YARenderingMode.h"

@interface YARecommendInterestTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *catNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIImageView *identifierIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hotIndexImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeadingConstraint;

@end

@implementation YARecommendInterestTableViewCell

- (void)setInterest:(YARecommendInterestModel *)interest {
    _interest = interest;

    // 头像
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:interest.icon] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (interest.isSubType) {
            self.iconImageView.image = [UIImage imageToRoundImageWithImage:image];
            self.identifierIconImageView.hidden = NO;
        } else {
            self.iconImageView.image = image;
            self.identifierIconImageView.hidden = YES;
        }
        
    }];
    // 标题
    self.titleLabel.text = interest.title;
    // 描述
    self.descLabel.text = interest.desc;
    // 分类名称
    self.catNameLabel.text = interest.catName;
    // 关注
    self.subLabel.text = interest.subString;
    // 热门分类中的排名
    if (interest.hotNO != 0) {
        self.hotIndexImageView.hidden = NO;
        self.hotIndexImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_interest_no%lu",(unsigned long)interest.hotNO]];
        self.titleLabelLeadingConstraint.constant = 25;
    } else {
        self.hotIndexImageView.hidden = YES;
        self.titleLabelLeadingConstraint.constant = 10;
    }
    
}
@end
