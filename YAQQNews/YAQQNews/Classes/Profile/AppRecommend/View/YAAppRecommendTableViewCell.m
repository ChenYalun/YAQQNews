//
//  YAAppRecommendTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/30.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAAppRecommendTableViewCell.h"
#import <UIImageView+YYWebImage.h>
#import "YAAppRecommendItem.h"

@interface YAAppRecommendTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation YAAppRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)gotoAppStore {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.item.url]];
}

- (void)setItem:(YAAppRecommendItem *)item {
    _item = item;
    
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:item.icon] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.titleLabel.text = item.name;
    self.descLabel.text = item.desc;
}
@end
