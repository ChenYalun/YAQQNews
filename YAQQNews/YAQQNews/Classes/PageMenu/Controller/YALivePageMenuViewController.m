//
//  YALivePageMenuViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALivePageMenuViewController.h"
#import "YALiveChannelViewController.h"

// 灰色边线的高度
static unsigned int const kGrayLayerHeight = 1;

@interface YALivePageMenuViewController ()

@end

@implementation YALivePageMenuViewController

- (instancetype)init {
    if (self = [super init]) {
        
        // 设置菜单按钮
        NSMutableArray *controllerArray = [NSMutableArray array];
        
        YALiveChannelViewController *mainChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeMain];
        mainChannelViewController.title = @"精选";
        
        YALiveChannelViewController *infoChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeInfo];
        infoChannelViewController.title = @"资讯";
        
        YALiveChannelViewController *artChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeArt];
        artChannelViewController.title = @"文艺";
        
        YALiveChannelViewController *entChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeEnt];
        entChannelViewController.title = @"娱乐";
        
        YALiveChannelViewController *financeChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeFinance];
        financeChannelViewController.title = @"财经";
        
        YALiveChannelViewController *tvChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeTV];
        tvChannelViewController.title = @"电视台";
        
        YALiveChannelViewController *sportsChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeSports];
        sportsChannelViewController.title = @"体育";
        
        YALiveChannelViewController *msjChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeMSJ];
        msjChannelViewController.title = @"慢视界";
        
        YALiveChannelViewController *lifesChannelViewController = [[YALiveChannelViewController alloc] initWithChannelType:LiveChannelTypeLifes];
        lifesChannelViewController.title = @"生活";

        [controllerArray addObjectsFromArray:@[
                                               mainChannelViewController,
                                               infoChannelViewController,
                                               artChannelViewController,
                                               entChannelViewController,
                                               financeChannelViewController,
                                               tvChannelViewController,
                                               sportsChannelViewController,
                                               msjChannelViewController,
                                               lifesChannelViewController
                                       
                                               ]];

        
        // 相关参数,注意通过参数设置,而不是通过属性设置
        NSDictionary *parameters = @{
                                     CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],// 菜单背景
                                     CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor darkGrayColor],//未选中字体颜色
                                     CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor blackColor],//选中文字颜色
                                     CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:16],// 普通字体
                                     CAPSPageMenuOptionScrollAnimationDurationOnMenuItemTap:@200, // 动画持续200毫秒
                                     CAPSPageMenuOptionMenuMargin: @10,// item间距10
                                     CAPSPageMenuOptionMenuItemWidthBasedOnTitleTextWidth: @YES,// 宽度48
                                     CAPSPageMenuOptionMenuHeight: @44, // item高度44
                                     CAPSPageMenuOptionSelectionIndicatorColor: kGlobalColor, // 选中指示器颜色
                                     CAPSPageMenuOptionSelectedMenuItemFont: [UIFont systemFontOfSize:17], // 选中字体
                                     };
        
        
        
        
        
        // 注意设置pageMenu的高度!
        self = [[YALivePageMenuViewController alloc] initWithViewControllers:controllerArray frame:CGRectMake(0, 20, kScreenWidth, kScreenHeight) options:parameters];
        
        
        // 设置灰色边缘
        CALayer *grayLayer = [[CALayer alloc] init];
        grayLayer.backgroundColor = kRGBAColor(210, 210, 210, 0.3).CGColor;
        grayLayer.frame = CGRectMake(0, 43, kScreenWidth, kGrayLayerHeight);
        [self.view.layer addSublayer:grayLayer];
        
    }
    return self;
}
@end
