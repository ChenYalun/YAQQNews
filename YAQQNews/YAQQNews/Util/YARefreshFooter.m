//
//  YARefreshFooter.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARefreshFooter.h"

@interface YARefreshFooter ()
{
    /** 显示刷新状态的label */
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation YARefreshFooter


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Set title
        [self setTitle:@"" forState:MJRefreshStateIdle];
        [self setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
        [self setTitle:@"已显示全部内容" forState:MJRefreshStateNoMoreData];

        // Set font
        self.stateLabel.font = [UIFont systemFontOfSize:15];
        
        // Set textColor
        self.stateLabel.textColor = [UIColor darkGrayColor];

    }
    return self;
}


@end
