//
//  AFJSONResponseSerializer+YATypeSupport.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/18.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "AFJSONResponseSerializer+YATypeSupport.h"

@implementation AFJSONResponseSerializer (YATypeSupport)
// 增加一个方法,扩充AFN的接收类型
- (instancetype)init {
    
    if (self = [super init]) {
        self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
        
    }
    
    return self;
}
@end
