//
//  YALiveContentPageViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveContentPageViewController.h"
#import "YALiveCommentViewController.h"
#import "YALiveMessageViewController.h"
#import "YANews.h"
#import "YALiveAboutViewController.h"

@interface YALiveContentPageViewController ()

@end

@implementation YALiveContentPageViewController

//- (void)configureUserInterface {
//    [super configureUserInterface];
//    UIView *view =  self.menuItems.firstObject;
//    CGPoint center = view.center;
//    
//    CGFloat width = 35;
//    self.selectionIndicatorView.frame = CGRectMake(center.x - width * 0.5, view.height - 2 , width , 2);
//}
//
//- (void)moveSelectionIndicator:(NSInteger)pageIndex {
//    [super moveSelectionIndicator:pageIndex];
//    UIView *view =  self.menuItems.firstObject;
//    CGPoint center = view.center;
//    
//    CGFloat width = 35;
//    self.selectionIndicatorView.frame = CGRectMake(center.x - width * 0.5, view.height - 2 , width , 2);
//}

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo {
    if (self = [super init]) {
        
        // 设置菜单按钮
        NSMutableArray *controllerArray = [NSMutableArray array];
        
        NewsArticleType type = [userInfo[@"type"] integerValue];
        if (type == NewsArticleTypeAboutLive) {
            YALiveAboutViewController *aboutViewController = [[YALiveAboutViewController alloc] init];
            aboutViewController.title = userInfo[@"aboutTitle"];
            

            YALiveMessageViewController *messageViewController = [[YALiveMessageViewController alloc] initWithUserInfo:userInfo];
            messageViewController.title = userInfo[@"peopleCount"];
            
            [controllerArray addObjectsFromArray:@[
                                                   aboutViewController,
                                                   messageViewController,
                                                   ]];
        } else {
            YALiveCommentViewController *commentViewController = [[YALiveCommentViewController alloc] initWithUserInfo:userInfo];
            commentViewController.title = userInfo[@"liveTitle"];
            
            YALiveMessageViewController *messageViewController = [[YALiveMessageViewController alloc] initWithUserInfo:userInfo];
            messageViewController.title = userInfo[@"peopleCount"];
            
            [controllerArray addObjectsFromArray:@[
                                                   commentViewController,
                                                   messageViewController,
                                                   ]];
        }

        
        
        // 相关参数,注意通过参数设置,而不是通过属性设置
        NSDictionary *parameters = @{
                                     CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],// 菜单背景
                                     CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor darkGrayColor],//未选中字体颜色
                                     CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor blackColor],//选中文字颜色
                                     CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:14],// 普通字体
                                     CAPSPageMenuOptionScrollAnimationDurationOnMenuItemTap:@200, // 动画持续200毫秒
                                     //CAPSPageMenuOptionMenuMargin: @10,// item间距10
//                                     CAPSPageMenuOptionMenuItemWidthBasedOnTitleTextWidth: @YES,// 宽度
                                     CAPSPageMenuOptionMenuHeight: @30, // item高度35
                                     CAPSPageMenuOptionSelectionIndicatorColor: kGlobalColor, // 选中指示器颜色
                                     CAPSPageMenuOptionSelectionIndicatorHeight: @2, // 指示器高度
                                     CAPSPageMenuOptionCenterMenuItems: @YES, // 居中显示
                                     CAPSPageMenuOptionMenuItemSeparatorWidth: @10, // 指示器宽度
                                     CAPSPageMenuOptionSelectedMenuItemFont: [UIFont systemFontOfSize:15], // 选中字体
                                     };
        
        
        
        // 注意设置pageMenu的高度!
        self = [[YALiveContentPageViewController alloc] initWithViewControllers:controllerArray frame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 200) options:parameters];
        
        
    }
    return self;
}


@end
