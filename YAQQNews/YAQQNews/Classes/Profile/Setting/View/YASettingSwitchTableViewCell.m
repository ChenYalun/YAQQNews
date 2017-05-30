//
//  YASettingSwitchTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YASettingSwitchTableViewCell.h"
#import "YASettingModel.h"

@interface YASettingSwitchTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@end
@implementation YASettingSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kRGBAColor(240, 240, 240, 1);
    self.selectedBackgroundView = view;
}

- (void)setSetting:(YASettingModel *)setting {
    _setting = setting;
    
    self.titleLabel.text = setting.title;
    self.promptLabel.text = setting.prompt;
}

@end
