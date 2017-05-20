//
//  YAProfileTableViewCell.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAProfileTableViewCell.h"
#import "YAProfileDetail.h"

@interface YAProfileTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
@implementation YAProfileTableViewCell

- (void)setDetail:(YAProfileDetail *)detail {
    _detail = detail;
    
    self.titleLabel.text = detail.title;
    self.descLabel.text = detail.desc;
    
}
@end
