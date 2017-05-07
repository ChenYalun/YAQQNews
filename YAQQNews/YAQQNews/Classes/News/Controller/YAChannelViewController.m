//
//  YAChannelViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/6.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAChannelViewController.h"
#import "YAChannelRequest.h"
#import "YANetWork.h"
#import "YANewsModel.h"
#import <MJRefresh.h>
#import "YACenterPhotoNewsCell.h"
#import "YARightPhotoNewsCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

typedef NS_ENUM(NSUInteger, RefreshType) {
    RefreshTypeForNew,
    RefreshTypeForMore
};

static NSString * const kYACenterPhotoNewsCellIdentifier = @"YACenterPhotoNewsCell";
static NSString * const kYARightPhotoNewsCellIdentifier = @"YARightPhotoNewsCell";

@interface YAChannelViewController ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <YANewsModel *> *newsList;
/** 新闻ID*/
@property (nonatomic, copy) NSMutableArray *newsIDs;
/** 页码 */
@property (nonatomic, strong) NSNumber *page;
@end

@implementation YAChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    self.tableView.separatorColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    //
    //    self.tableView.estimatedRowHeight = 213;
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.tableView.showsVerticalScrollIndicator = YES;
    

    [self.tableView registerNib:[UINib nibWithNibName:[YACenterPhotoNewsCell className] bundle:nil] forCellReuseIdentifier:kYACenterPhotoNewsCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:[YARightPhotoNewsCell className] bundle:nil] forCellReuseIdentifier:kYARightPhotoNewsCellIdentifier];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshForNew)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshForMore)];
    
    //[self.tableView.mj_header beginRefreshing];
    
}

// 下拉刷新
- (void)refreshForNew {
    [self refreshForNewsWithPage:self.page refreshType:RefreshTypeForNew];
}

// 上拉加载
- (void)refreshForMore {
    [self refreshForNewsWithPage:self.page refreshType:RefreshTypeForMore];
}

- (void)refreshForNewsWithPage:(NSNumber *)page refreshType:(RefreshType)type {
    
    YAChannelRequest *request = [[YAChannelRequest alloc] initWithChannel:RequestChannelOptionsSports | RequestChannelOptionsFinance | RequestChannelOptionsVideo page:self.page];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSArray *array = [YANewsModel newsModelWithKeyValuesArray:request.responseObject];
        
        for (YANewsModel *model in self.newsList) {
            [self.newsIDs addObject:model.ID];
        }
        
        // 剔除重复的新闻
        NSMutableArray *tempArray = [NSMutableArray array];
        for (YANewsModel *model in array) {
            if (![self.newsIDs containsObject:model.ID]) {
                [tempArray addObject:model];
            }
        }
        
        
        if (type == RefreshTypeForNew) {
            if (self.newsList.firstObject.stick) {
                [self.newsList insertObjects:tempArray atIndex:1];
            } else {
                [self.newsList insertObjects:tempArray atIndex:0];
            }
            
        } else {
                [self.newsList addObjectsFromArray:tempArray];
        }
        
        
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        //NSLog(@"%@",request.responseString);
        
        self.page = [NSNumber numberWithInteger:self.page.integerValue + 1];
        
        [self.tableView reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        NSLog(@"%@",request.error);
    }];
    
}



 #pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsModel *news = self.newsList[indexPath.row];
    
    if (news.thumbnails.count > 3) {
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

- (NSNumber *)page {
    if (!_page) {
        _page = @0;
    }
    return _page;
}
@end
