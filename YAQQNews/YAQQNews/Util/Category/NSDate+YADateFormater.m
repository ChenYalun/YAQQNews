//
//  NSDate+YADateFormater.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "NSDate+YADateFormater.h"

@implementation NSDate (YADateFormater)
+ (NSDate *)ya_dateFromISO8601StringDateFormatter:(NSString *)string locale:(NSLocale *)locale{
    if (!string) {
        return nil;
    }
    struct tm tm;
    time_t t;
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%d %H:%M:%S", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}

- (NSString *)ya_ISO8601String:(NSDate*)date {
    struct tm *timeinfo;
    char buffer[80];
    time_t rawtime = [date timeIntervalSince1970] - [[NSTimeZone localTimeZone] secondsFromGMT];
    timeinfo = localtime(&rawtime);
    strftime(buffer, 80, "%Y-%m-%d %H:%M:%S", timeinfo);
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

@end
