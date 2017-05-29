//
//  YARecommendTopicPageMenuViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicPageMenuViewController.h"
#import "YARecommendInterestTableViewController.h"
#import "YARecommendInterestModel.h"

@interface YARecommendTopicPageMenuViewController ()

@end

@implementation YARecommendTopicPageMenuViewController

- (instancetype)initWithResponseObject:(id)responseObject {
    if (self = [super init]) {
        
        NSArray *titleArray = [YARecommendInterestModel loadTitleListWithObject:responseObject];
        
        // 设置菜单按钮
        NSMutableArray *controllerArray = [NSMutableArray array];
        [titleArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 获取模型数组
            NSArray *modelArray = [YARecommendInterestModel loadInterestWithObject:responseObject index:idx];
            // 设置模型数组
            YARecommendInterestTableViewController *viewController = [[YARecommendInterestTableViewController alloc] initWithInterestModelArray:modelArray];
            // 设置标题
            viewController.title = obj;
            [controllerArray addObject:viewController];
        }];
        

        
        // 相关参数,注意通过参数设置,而不是通过属性设置
        NSDictionary *parameters = @{
                                     CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],// 菜单背景
                                     CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor darkGrayColor],//未选中字体颜色
                                     CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor blackColor],//选中文字颜色
                                     CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:14],// 普通字体
                                     CAPSPageMenuOptionScrollAnimationDurationOnMenuItemTap:@200, // 动画持续200毫秒
                                     CAPSPageMenuOptionMenuMargin: @10,// item间距10
                                     CAPSPageMenuOptionMenuItemWidth: @40,// 宽度48
                                     CAPSPageMenuOptionMenuHeight: @44, // item高度44
                                     CAPSPageMenuOptionSelectionIndicatorColor: kGlobalColor, // 选中指示器颜色
                                     CAPSPageMenuOptionSelectedMenuItemFont: [UIFont systemFontOfSize:14], // 选中字体
                                     };
        
        // 注意设置pageMenu的高度!
        self = [[YARecommendTopicPageMenuViewController alloc] initWithViewControllers:controllerArray frame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) options:parameters];
        

        
    }
    return self;
}

@end

