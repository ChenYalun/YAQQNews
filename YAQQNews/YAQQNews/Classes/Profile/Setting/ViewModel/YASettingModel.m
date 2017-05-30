//
//  YASettingModel.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/30.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YASettingModel.h"

@implementation YASettingModel
+(NSArray<NSArray *> *)loadSettingModelSectionList {
    
    YASettingModel *weChat = [YASettingModel new];
    weChat.title = @"微信";
    weChat.desc = @"未绑定";
    
    YASettingModel *qq = [YASettingModel new];
    qq.title = @"QQ";
    qq.desc = @"未绑定";
    
    YASettingModel *tencentWeiBo = [YASettingModel new];
    tencentWeiBo.title = @"腾讯微博";
    tencentWeiBo.desc = @"未绑定";
    
    YASettingModel *sinaWeiBo = [YASettingModel new];
    sinaWeiBo.title = @"新浪微博";
    sinaWeiBo.desc = @"未绑定";
    
    YASettingModel *font = [YASettingModel new];
    font.title = @"字号调整";
    font.desc = @"标准";
    
    YASettingModel *video = [YASettingModel new];
    video.title = @"视频自动播放";
    
    YASettingModel *newsPush = [YASettingModel new];
    newsPush.title = @"新闻推送";
    newsPush.prompt = @"关闭时可能错过重要资讯通知";
    
    YASettingModel *clearMemory = [YASettingModel new];
    clearMemory.title = @"清理缓存";
    
    YASettingModel *about = [YASettingModel new];
    about.title = @"关于";
    about.desc = @"未绑定";
    
    YASettingModel *privacy = [YASettingModel new];
    privacy.title = @"隐私协议";
    privacy.url = [NSURL URLWithString:@"http://r.inews.qq.com/privacy?qntimestamp=1496038544&isnm=1"];
    
    YASettingModel *appStore = [YASettingModel new];
    appStore.title = @"去App Store评分";
    appStore.url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/id399363156?mt=8"];
    
    YASettingModel *activity = [YASettingModel new];
    activity.title = @"活动";
    activity.url = [NSURL URLWithString:@"http://2000014734.zhan.qq.com/text1.html?isnm=1"];
    
    YASettingModel *recommend = [YASettingModel new];
    recommend.title = @"精品推荐";
    recommend.url = [NSURL URLWithString:@"http://r.inews.qq.com/getAppWallNews"];
    

    return @[@[weChat, qq, tencentWeiBo, sinaWeiBo], @[font, video, newsPush], @[clearMemory], @[about, privacy, appStore, activity, recommend]];
    
}
@end
