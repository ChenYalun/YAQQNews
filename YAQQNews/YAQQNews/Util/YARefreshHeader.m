//
//  YARefreshHeader.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARefreshHeader.h"

@implementation YARefreshHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        // 设置原始图片
        [self setImages:@[[UIImage imageNamed:@"earth_0"]] forState:MJRefreshStateIdle];
        
        // 设置刷新图片
        NSMutableArray *refreshImages = [NSMutableArray array];
        for (NSUInteger i = 0; i < 23; i++) {
            [refreshImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"earth_%lu", (unsigned long)i]]];
        }
        [self setImages:refreshImages forState:MJRefreshStatePulling];
        
        // 设置释放图片
        NSArray *pullImages = [[refreshImages reverseObjectEnumerator] allObjects];
        [self setImages:pullImages forState:MJRefreshStatePulling];
    }
    return self;
}
@end
