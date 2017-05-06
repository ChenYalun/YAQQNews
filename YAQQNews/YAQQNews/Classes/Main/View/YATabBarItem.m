//
//  YATabBarItem.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/5.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YATabBarItem.h"
#import "UIImage+YARenderingMode.h"

@implementation YATabBarItem
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    
    if (self = [super initWithTitle:title image:[image ya_originImage]  selectedImage:[selectedImage ya_originImage]]) {
        [self setTitlePositionAdjustment:UIOffsetMake(0, -2)];
        [self setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
        //        [self setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    return self;
}
@end
