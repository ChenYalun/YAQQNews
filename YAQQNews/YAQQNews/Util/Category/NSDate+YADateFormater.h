//
//  NSDate+YADateFormater.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YADateFormater)
+ (NSDate *)ya_dateFromISO8601StringDateFormatter:(NSString *)string locale:(NSLocale *)locale;

- (NSString *)ya_ISO8601String:(NSDate*)date;

@end
