//
//  YAAppRecommendViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/30.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAAppRecommendViewController.h"
#import "YAAppRecommendItem.h"
#import "YANavigationView.h"
#import "YARefreshHeader.h"
#import "YAAppRecommendTableViewCell.h"
#import <UIImageView+YYWebImage.h>

static NSString * const kYAAppRecommendTableViewCellIdentifier = @"YAAppRecommendTableViewCell";

@interface YAAppRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <YAAppRecommendItem *> *itemList;
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, copy) NSString *bannerUrlString;
@end

@implementation YAAppRecommendViewController

 #pragma mark – Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationView];
    
    [self setupBanner];
    
    [self.tableView.mj_header beginRefreshing];
    
}

 #pragma mark – Events

// 设置导航视图
- (void)setupNavigationView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    YANavigationView *navigationView = [YANavigationView navigationView];
    navigationView.hiddenMenuButton = YES;
    navigationView.frame = CGRectMake(0, 20, kScreenWidth, 44);
    navigationView.title = @"精品推荐";
    [self.view addSubview:navigationView];
}

// 设置顶部banner
- (void)setupBanner {
    UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    self.bannerImageView = bannerImageView;
    bannerImageView.userInteractionEnabled = YES;
    bannerImageView.clipsToBounds = YES;
    bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.tableHeaderView = bannerImageView;
    
    [self.bannerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.bannerUrlString]];
    }]];
    
}

// 刷新方法
- (void)refreshForNew {
    
    [YAAppRecommendItem loadAppRecommendItemAndBannerCompletionBlockWithSuccess:^(NSArray<YAAppRecommendItem *> *appRecommendItemList, NSString *bannerURL, NSString *bannerImage) {
        [self.itemList removeAllObjects];
        [self.itemList addObjectsFromArray:appRecommendItemList];
        self.bannerUrlString = bannerURL;
        [self.bannerImageView yy_setImageWithURL:[NSURL URLWithString:bannerImage] options:YYWebImageOptionSetImageWithFadeAnimation];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

 #pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YAAppRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYAAppRecommendTableViewCellIdentifier forIndexPath:indexPath];
    cell.item = self.itemList[indexPath.row];
    return cell;
}

#pragma mark – Getters and Setters

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        [_tableView registerNib:[UINib nibWithNibName:[YAAppRecommendTableViewCell className] bundle:nil] forCellReuseIdentifier:kYAAppRecommendTableViewCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = kRGBAColor(245, 245, 245, 0.4);
        _tableView.rowHeight = 70;
        _tableView.mj_header = [YARefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshForNew)];
        
        UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        footLabel.text = @"已显示全部内容";
        footLabel.textAlignment = NSTextAlignmentCenter;
        footLabel.font = [UIFont systemFontOfSize:14];
        footLabel.textColor = [UIColor lightGrayColor];
        _tableView.tableFooterView = footLabel;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray<YAAppRecommendItem *> *)itemList {
    if (!_itemList) {
        _itemList = [NSMutableArray array];
    }
    return _itemList;
}

@end
