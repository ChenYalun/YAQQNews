//
//  YARecommendTopicSectionHeaderView.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/27.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicSectionHeaderView.h"

@interface YARecommendTopicSectionHeaderView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation YARecommendTopicSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        _titleLabel = label;
        
        label.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:label];
        
        // 添加指示图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 20, 15, 6, 8)];
        [imageView setImage:kGetImage(@"profile_arrow_constellation")];
        [self addSubview:imageView];
        
        // 添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionViewDidTap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

// 设置标题
- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

// 便捷构造
+ (instancetype)topicSectionHeaderView {
    YARecommendTopicSectionHeaderView *view = [[YARecommendTopicSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    return view;
}

// 点击事件
- (void)sectionViewDidTap {
    kLog(@"点击了该view");
}
@end
