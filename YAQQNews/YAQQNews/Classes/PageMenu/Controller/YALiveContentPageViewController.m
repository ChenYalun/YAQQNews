//
//  YALiveContentPageViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveContentPageViewController.h"
#import "YALiveCommentViewController.h"

@interface YALiveContentPageViewController ()

@end

@implementation YALiveContentPageViewController

- (instancetype)init {
    if (self = [super init]) {
        
        // 设置菜单按钮
        NSMutableArray *controllerArray = [NSMutableArray array];
        
        YALiveCommentViewController *commentViewController = [[YALiveCommentViewController alloc] init];
        
        commentViewController.title = @"主播厅";
        
        UITableViewController *infoChannelViewController = [[UITableViewController alloc] init];
        infoChannelViewController.title = @"资讯";
        
        [controllerArray addObjectsFromArray:@[
                                               commentViewController,
                                               infoChannelViewController,
                                               ]];
        
        
        // 相关参数,注意通过参数设置,而不是通过属性设置
        NSDictionary *parameters = @{
                                     CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],// 菜单背景
                                     CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor darkGrayColor],//未选中字体颜色
                                     CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor blackColor],//选中文字颜色
                                     CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:16],// 普通字体
                                     CAPSPageMenuOptionScrollAnimationDurationOnMenuItemTap:@200, // 动画持续200毫秒
                                     //CAPSPageMenuOptionMenuMargin: @10,// item间距10
                                     CAPSPageMenuOptionMenuItemWidthBasedOnTitleTextWidth: @YES,// 宽度48
                                     CAPSPageMenuOptionMenuHeight: @44, // item高度44
                                     CAPSPageMenuOptionSelectionIndicatorColor: kGlobalColor, // 选中指示器颜色
                                     CAPSPageMenuOptionSelectedMenuItemFont: [UIFont systemFontOfSize:17], // 选中字体
                                     };
        
        
        
        
        
        // 注意设置pageMenu的高度!
        self = [[YALiveContentPageViewController alloc] initWithViewControllers:controllerArray frame:CGRectMake(0, 20, kScreenWidth, kScreenHeight) options:parameters];
        
        
    }
    return self;
}


@end
