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
        
        //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 20, 30, 30)];
        //[imageView setImage:kGetImage(@"profile_arrow_constellation")];
        //[self addSubview:imageView];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

+ (instancetype)topicSectionHeaderView {
    YARecommendTopicSectionHeaderView *view = [[YARecommendTopicSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor orangeColor];
    return view;
}
@end
