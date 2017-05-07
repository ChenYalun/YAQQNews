//
//  YANewsPageMenuViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsPageMenuViewController.h"
#import "YAChannelViewController.h"

// 灰色边线的高度
static unsigned int const kGrayLayerHeight = 1;
// 指示按钮宽度
static unsigned int const kAddButtonWidth = 35;
// 指示按钮高度
static unsigned int const kAddButonHeight = 43;

@implementation YANewsPageMenuViewController

- (instancetype)init {
    if (self = [super init]) {
        
        // 设置菜单按钮
        NSMutableArray *controllerArray = [NSMutableArray array];
        YAChannelViewController *channelViewController = [[YAChannelViewController alloc] init];
        channelViewController.title = @"要闻";
        
        UITableViewController *t1 = [[UITableViewController alloc] init];
        t1.title = @"娱乐";
        UITableViewController *t2 = [[UITableViewController alloc] init];
        t2.title = @"视频";
        UITableViewController *t3 = [[UITableViewController alloc] init];
        t3.title = @"直播";
        UITableViewController *t4 = [[UITableViewController alloc] init];
        t4.title = @"财经";
        UITableViewController *t5 = [[UITableViewController alloc] init];
        t5.title = @"文化";
        UITableViewController *t6 = [[UITableViewController alloc] init];
        t6.title = @"本地";
        UITableViewController *t7 = [[UITableViewController alloc] init];
        t7.title = @"时事";
        UITableViewController *t8 = [[UITableViewController alloc] init];
        t8.title = @"三农";
        UITableViewController *t9 = [[UITableViewController alloc] init];
        t9.title = @"金融";
        [controllerArray addObject:channelViewController];
        [controllerArray addObject:t1];
        [controllerArray addObject:t2];
        [controllerArray addObject:t3];
        [controllerArray addObject:t4];
        [controllerArray addObject:t5];
        [controllerArray addObject:t6];
        [controllerArray addObject:t7];
        [controllerArray addObject:t8];
        [controllerArray addObject:t9];
        
        // 相关参数,注意通过参数设置,而不是通过属性设置
        NSDictionary *parameters = @{
                                     CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],// 菜单背景
                                     CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor darkGrayColor],//未选中字体颜色
                                     CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor blackColor],//选中文字颜色
                                     CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:16],// 普通字体
                                     CAPSPageMenuOptionScrollAnimationDurationOnMenuItemTap:@200, // 动画持续200毫秒
                                     CAPSPageMenuOptionMenuMargin: @10,// item间距10
                                     CAPSPageMenuOptionMenuItemWidth: @40,// 宽度48
                                     CAPSPageMenuOptionMenuHeight: @44, // item高度44
                                     CAPSPageMenuOptionSelectionIndicatorColor: kGlobalColor, // 选中指示器颜色
                                     CAPSPageMenuOptionSelectedMenuItemFont: [UIFont systemFontOfSize:17], // 选中字体
                                     };
        
       

        
        
        // 注意设置pageMenu的高度!
        self = [[YANewsPageMenuViewController alloc] initWithViewControllers:controllerArray frame:CGRectMake(0, 20, kScreenWidth, kScreenHeight) options:parameters];
        
        // 设置灰色边缘
        CALayer *grayLayer = [[CALayer alloc] init];
        grayLayer.backgroundColor = kRGBAColor(210, 210, 210, 0.3).CGColor;
        grayLayer.frame = CGRectMake(0, 43, kScreenWidth, kGrayLayerHeight);
        [self.view.layer addSublayer:grayLayer];
        
        
        // 设置提示按钮
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setImage:kGetImage(@"timeline_add_Channel_black") forState:UIControlStateNormal];
        addButton.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:addButton];
        addButton.frame = CGRectMake(kScreenWidth - kAddButtonWidth, 0, kAddButtonWidth, kAddButonHeight);
        
        
        
    }
    return self;
}

@end
