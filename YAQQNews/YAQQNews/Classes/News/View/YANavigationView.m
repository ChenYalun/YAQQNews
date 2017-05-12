//
//  YANavigationView.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANavigationView.h"

@interface YANavigationView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation YANavigationView

 #pragma mark – Life Cycle
// 快速创建
+ (instancetype)navigationViewWithTitle:(NSString *)title {
    YANavigationView *view = [[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil].firstObject;
    view.titleLabel.text = title;
    return view;
}

 #pragma mark – Events
// 返回
- (IBAction)back:(UIButton *)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

// 弹出菜单
- (IBAction)menu:(UIButton *)sender {
    
}

@end
