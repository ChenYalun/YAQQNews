//
//  UIImage+YARenderingMode.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/5.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "UIImage+YARenderingMode.h"

@implementation UIImage (YARenderingMode)
- (instancetype)ya_originImage {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
