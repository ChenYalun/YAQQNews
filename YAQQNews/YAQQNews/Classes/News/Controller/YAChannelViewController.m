//
//  YAChannelViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAChannelViewController.h"
#import "YANewsModel.h"
#import "YACenterPhotoNewsCell.h"
#import "YARightPhotoNewsCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YANewsContentViewController.h"
#import <MJRefresh.h>
#import "YANotification.h"

static NSString * const kYACenterPhotoNewsCellIdentifier = @"YACenterPhotoNewsCell";
NSString * const kYARightPhotoNewsCellIdentifier = @"YARightPhotoNewsCell";

@interface YAChannelViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 控制器类型 */
@property (nonatomic, assign) YAViewControllerType viewControllerType;
@property (nonatomic, strong) NSMutableArray <YANewsModel *> *newsList;
/** 新闻ID*/
@property (nonatomic, copy) NSMutableArray *newsIDs;
/** 页码 */
@property (nonatomic, assign) NSUInteger page;
@end

@implementation YAChannelViewController

 #pragma mark – Life Cycle

- (instancetype)initWithViewControllerType:(YAViewControllerType)viewControllerType {
    if (self = [super init]) {
        self.viewControllerType = viewControllerType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.mj_header beginRefreshing];
}

 #pragma mark – Events

// 下拉刷新
- (void)refreshForNew {
    [self refreshForNewsWithPage:self.page refreshType:RefreshTypeForNew];
}

// 上拉加载
- (void)refreshForMore {
    [self refreshForNewsWithPage:self.page refreshType:RefreshTypeForMore];
}

- (void)refreshForNewsWithPage:(NSUInteger)page refreshType:(RefreshType)type {
    [YANewsModel loadNewsListWithViewControllerType:self.viewControllerType page:self.page refreshType:type newsIDs:self.newsIDs newsList:self.newsList completionBlockWithSuccess:^(NSMutableArray<YANewsModel *> *newsList) {
        
        self.newsList = newsList;
        self.page += 1;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        kLog(@"%@",error);
    }];
    
}

 #pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsModel *news = self.newsList[indexPath.row];
    
    if (news.articletype == NewsArticleTypePicture) {
        YACenterPhotoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kYACenterPhotoNewsCellIdentifier forIndexPath:indexPath];
        cell.news = news;
        return cell;
    } else {
        YARightPhotoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kYARightPhotoNewsCellIdentifier forIndexPath:indexPath];
        cell.news = news;
        return cell;
    }
    
    
    /*
    switch (news.picShowType) {
        case NewsPicShowTypeRightPhoto:
        {
            YARightPhotoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kYARightPhotoNewsCellIdentifier forIndexPath:indexPath];
            cell.news = news;
            return cell;
        }
            break;
            
        default:
        {
            YACenterPhotoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kYACenterPhotoNewsCellIdentifier forIndexPath:indexPath];
            cell.news = news;
            return cell;
        }
    }
    
     */
    
}


 #pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsModel *news = self.newsList[indexPath.row];
    
    if (news.thumbnails.count > 3) {
        return [tableView fd_heightForCellWithIdentifier:kYACenterPhotoNewsCellIdentifier cacheByIndexPath:indexPath configuration:^(YACenterPhotoNewsCell *cell) {
            cell.news = self.newsList[indexPath.row];
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:kYARightPhotoNewsCellIdentifier cacheByIndexPath:indexPath configuration:^(YARightPhotoNewsCell *cell) {
            cell.news = self.newsList[indexPath.row];
        }];
}
    

    
    
    /*
    switch (news.picShowType) {
        case NewsPicShowTypeRightPhoto:
        {
            return [tableView fd_heightForCellWithIdentifier:kYARightPhotoNewsCellIdentifier cacheByIndexPath:indexPath configuration:^(YARightPhotoNewsCell *cell) {
                cell.news = self.newsList[indexPath.row];
            }];
        }
            break;
            
            
        default:
        {
            return [tableView fd_heightForCellWithIdentifier:kYACenterPhotoNewsCellIdentifier cacheByIndexPath:indexPath configuration:^(YACenterPhotoNewsCell *cell) {
                cell.news = self.newsList[indexPath.row];
            }];
        }
            
    }
    */
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsModel *news = self.newsList[indexPath.row];
    if (news.articletype == NewsArticleTypeNormal) {
        YANewsContentViewController *contentViewController = [[YANewsContentViewController alloc] initWithNews:news];
        [self.navigationController pushViewController:contentViewController animated:YES];
    } else {
        
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [[NSNotificationCenter defaultCenter] postNotificationName:kYANewsListScrollViewOffsetNotification object:nil userInfo:@{@"offsetY": [NSNumber numberWithFloat:scrollView.contentOffset.y]}];
    
}

 #pragma mark – Getters and Setters

- (NSMutableArray <YANewsModel *> *)newsList {
    if (!_newsList) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _tableView.showsVerticalScrollIndicator = YES;
        [_tableView registerNib:[UINib nibWithNibName:[YACenterPhotoNewsCell className] bundle:nil] forCellReuseIdentifier:kYACenterPhotoNewsCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:[YARightPhotoNewsCell className] bundle:nil] forCellReuseIdentifier:kYARightPhotoNewsCellIdentifier];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshForNew)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshForMore)];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

- (NSMutableArray *)newsIDs {
    if (!_newsIDs) {
        _newsIDs = [NSMutableArray array];
    }
    return _newsIDs;
}

@end
