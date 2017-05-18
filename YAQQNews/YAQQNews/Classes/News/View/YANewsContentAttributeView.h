//
//  YANewsContentAttributeView.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/18.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YANewsContentAttributeView : UIView
@property (nonatomic, copy) NSDictionary *attribute;
+ (instancetype)contentAttributeTitleView;
@end
