//
//  YARecommendTopicContentHeader.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicContentHeader.h"
#import "YARecommendTopicContentHeaderRequest.h"
#import <UIImageView+YYWebImage.h>

@implementation YARecommendTopicContentHeader

+ (void)setUpTopicContentHeaderWithTopicID:(NSString *)topicID titleLabel:(UILabel *)titleLabel descLabel:(UILabel *)descLabel subLabel:(UILabel *)subLabel pubLabel:(UILabel *)pubLabel backImageView:(UIImageView *)backImageView {
 
    YARecommendTopicContentHeader *header = [[YARecommendTopicContentHeader alloc] init];

    // 发送请求
    YARecommendTopicContentHeaderRequest *request = [[YARecommendTopicContentHeaderRequest alloc] initWithTopicID:topicID];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseObject[@"info"];
        
        header.desc = dict[@"desc"];
        header.icon = dict[@"icon"];
        header.pubString = [NSString stringWithFormat:@"%ld发布",[dict[@"pubCount"] integerValue]];
        header.subString = [NSString stringWithFormat:@"%ld关注",[dict[@"subCount"] integerValue]];
        header.tpname = dict[@"tpname"];
        header.tpid = dict[@"tpid"];
        
        
        
        titleLabel.text = header.tpname;
        descLabel.text = header.desc;
        subLabel.text = header.subString;
        pubLabel.text = header.pubString;
        [backImageView yy_setImageWithURL:[NSURL URLWithString:header.icon] options:YYWebImageOptionSetImageWithFadeAnimation];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];

}
@end
