//
//  YASettingModel.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/30.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YASettingModel : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 小字提示 */
@property (nonatomic, copy) NSString *prompt;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 可能存在的url */
@property (nonatomic, strong) NSURL *url;

+ (NSArray <NSArray *> *)loadSettingModelSectionList;
@end
