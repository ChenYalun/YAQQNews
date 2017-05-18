//
//  YANewsContentAttributeView.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/18.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContentAttributeView.h"
#import <YYImage.h>

@interface YANewsContentAttributeView ()

// 图片匹配的文本
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *happyLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestLabel;
@property (weak, nonatomic) IBOutlet UILabel *sadLabel;


// 动图
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *careImageView;
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *happyImageView;
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *requestImageView;
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *sadImageView;

@end
@implementation YANewsContentAttributeView

+ (instancetype)contentAttributeTitleView {
    YANewsContentAttributeView *attributeTitleView = [[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil].firstObject;
    attributeTitleView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    attributeTitleView.careImageView.image = [YYImage imageNamed:@"care_gif@2x.gif"];
    attributeTitleView.happyImageView.image = [YYImage imageNamed:@"happy_gif@2x.gif"];
    attributeTitleView.requestImageView.image = [YYImage imageNamed:@"request_gif@2x.gif"];
    attributeTitleView.sadImageView.image = [YYImage imageNamed:@"sad_gif@2x.gif"];
    
    return attributeTitleView;
}

- (void)setAttribute:(NSDictionary *)attribute {
    _attribute = attribute;
    
    self.likeLabel.text = attribute[@"喜欢"];
    self.happyLabel.text = attribute[@"开心"];
    self.requestLabel.text = attribute[@"一般"];
    self.sadLabel.text = attribute[@"不开心"];
}
@end
