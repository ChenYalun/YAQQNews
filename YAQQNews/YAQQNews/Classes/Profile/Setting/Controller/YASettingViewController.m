//
//  YASettingViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YASettingViewController.h"
#import "YASettingModel.h"
#import "YASettingNormalTableViewCell.h"
#import "YASettingSwitchTableViewCell.h"
#import "YANavigationView.h"
#import "YANormalWebViewController.h"
#import "YAAppRecommendViewController.h"

static NSString * const kYASettingNormalTableViewCellIdentifier = @"YASettingNormalTableViewCell";
static NSString * const kYASettingSwitchTableViewCellIdentifier = @"YASettingSwitchTableViewCell";

@interface YASettingViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSArray *> *settingList;
@end

@implementation YASettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    YANavigationView *navigationView = [YANavigationView navigationView];
    navigationView.hiddenMenuButton = YES;
    navigationView.frame = CGRectMake(0, 20, kScreenWidth, 44);
    navigationView.title = @"设置";
    [self.view addSubview:navigationView];
    self.tableView.rowHeight = 50;
    [self.settingList addObjectsFromArray:[YASettingModel loadSettingModelSectionList]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settingList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingList[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YASettingModel *setting = self.settingList[indexPath.section][indexPath.row];

    if ([setting.title isEqualToString:@"新闻推送"]) {
        YASettingSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYASettingSwitchTableViewCellIdentifier forIndexPath:indexPath];
        cell.setting = setting;
        return cell;
    } else {
        YASettingNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYASettingNormalTableViewCellIdentifier forIndexPath:indexPath];
        cell.setting = setting;
        return cell;
    }
 
}

 #pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, 50)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [view addSubview:label];
    
    if (section == 0) {
        label.attributedText = [[NSAttributedString alloc] initWithString:@"分享绑定" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        return view;
    }
    
    if (section == 1) {
        label.attributedText = [[NSAttributedString alloc] initWithString:@"阅读模式" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 ) {
        return 50;
    } else {
        return 20;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.settingList.count - 1) {
        return 20;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        kLog(@"清除缓存");
    }
    
    if (indexPath.section == 3) {
        YASettingModel *setting = self.settingList[indexPath.section][indexPath.row];
        switch (indexPath.row) {
            case 0:
                kLog(@"关于页面");
                break;
            case 2: // 跳转到AppStore
                [[UIApplication sharedApplication] openURL:setting.url];
                break;
            case 4: // 精品推荐
                [self.navigationController pushViewController:[[YAAppRecommendViewController alloc] init] animated:YES];
                break;
            default:
                [self.navigationController pushViewController:[[YANormalWebViewController alloc] initWithMainURL:setting.url] animated:YES];
        }
    }
    
    
}
 #pragma mark – Getters and Setters

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:[YASettingNormalTableViewCell className] bundle:nil] forCellReuseIdentifier:kYASettingNormalTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:[YASettingSwitchTableViewCell className] bundle:nil] forCellReuseIdentifier:kYASettingSwitchTableViewCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = kRGBAColor(245, 245, 245, 0.4);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray <NSArray *>*)settingList {
    if (!_settingList) {
        _settingList = [NSMutableArray array];
    }
    return _settingList;
}

@end
