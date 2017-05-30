//
//  YASettingNormalTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YASettingNormalTableViewCell.h"
#import "YASettingModel.h"

@interface YASettingNormalTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation YASettingNormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kRGBAColor(240, 240, 240, 1);
    self.selectedBackgroundView = view;
}

- (void)setSetting:(YASettingModel *)setting {
    _setting = setting;
    
    self.titleLabel.text = setting.title;
    self.descLabel.text = setting.desc;
}


@end
