//
//  UIImage+YARenderingMode.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/5.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YARenderingMode)
- (instancetype)ya_originImage;
+ (UIImage *)imageToRoundImageWithImage:(UIImage *)image;
+ (UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size;
+ (CGSize)normalImageSizeWithOriginImageSize:(CGSize)size;
@end
