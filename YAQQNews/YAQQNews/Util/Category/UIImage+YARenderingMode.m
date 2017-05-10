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

+ (UIImage *)imageToRoundImageWithImage:(UIImage *)image {
    if (!image)return nil;
    
    //    1、开启位图上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0) ;
    
    //    2、描述圆形裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)] ;
    
    //    3、设置裁剪区域
    [clipPath addClip] ;
    
    //    4、绘图
    [image drawAtPoint:CGPointZero] ;
    
    //    5、取出图片
    image = UIGraphicsGetImageFromCurrentImageContext() ;
    
    //    6、关闭图片上下文
    UIGraphicsEndImageContext() ;
    
    return image ;
}


// 裁剪图片
+ (UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size {
    
    // 得到图片上下文，指定绘制范围
    UIGraphicsBeginImageContext(size);
    
    // 将图片按照指定大小绘制
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前图片上下文中导出图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 当前图片上下文出栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
