//
//  YAHeaderLabel.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAHeaderLabel.h"

@implementation YAHeaderLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)setNum:(NSUInteger)num {
    _num = num;
    
    NSString *numString = [NSString stringWithFormat:@"%ld场直播预告", num];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:numString];
    
    NSRange range =  [numString rangeOfString:@"直播预告"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#4F98D7"] range:NSMakeRange(0, numString.length - range.length)];
    
    [self setAttributedText:attributedString];
}



@end
