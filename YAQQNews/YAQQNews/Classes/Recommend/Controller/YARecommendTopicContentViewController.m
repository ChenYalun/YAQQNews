//
//  YARecommendTopicContentViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/28.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicContentViewController.h"
#import "YARecommendTopicContentHeader.h"
#import "YARecommendTopicContentListModel.h"
#import "YARightPhotoNewsCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YARefreshFooter.h"

static NSUInteger count = 20;

static NSString * const kYARightPhotoNewsCellIdentifier = @"YARightPhotoNewsCell";

@interface YARecommendTopicContentViewController () <UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 话题类型 */
@property (nonatomic, copy) NSString *topicID;
/** 话题数组 */
@property (nonatomic, strong) NSMutableArray <YARecommendTopicContentListModel *> *topicList;
/** 新闻列表ID */
@property (nonatomic, strong) NSMutableArray *ids;
/** 页码 */
@property (nonatomic, assign) NSUInteger index;
/** 是否是首次加载 */
@property (nonatomic, assign) BOOL isFirst;
// 头部控件
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@end

@implementation YARecommendTopicContentViewController

 #pragma mark – Life Cycle

- (instancetype)initWithTopicID:(NSString *)topicID {
    if (self = [super init]) {
        _topicID = topicID;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [YARecommendTopicContentHeader setUpTopicContentHeaderWithTopicID:self.topicID titleLabel:self.titleLabel descLabel:self.descLabel subLabel:self.subLabel pubLabel:self.pubLabel backImageView:self.backImageView];
    
    self.isFirst = YES;
    self.index = 1;
    self.tableView.mj_footer = [YARefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshForMore)];
    [self.tableView.mj_footer beginRefreshing];
}

 #pragma mark – Events

// 上拉加载
- (void)refreshForMore {

    NSArray *requestArray;
    
    if (self.isFirst) {
        requestArray = self.ids;
    } else {
        NSRange range;
        
        if (self.index + count <= self.ids.count) {
            range = NSMakeRange(self.index, count);
        } else {
            range = NSMakeRange(self.index, self.ids.count - self.index);
        }
        requestArray = [self.ids subarrayWithRange:range];
    }
    
     [YARecommendTopicContentListModel loadTopicContentListForArray:self.topicList topicID:self.topicID ids:requestArray isFirst:self.isFirst  completionBlockWithSuccess:^(NSMutableArray<YANewsModel *> *newsList) {
         [self.tableView reloadData];
         self.index = self.topicList.count;
         
         if (self.index == self.ids.count) {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
             return ;
         }
         
        
         self.isFirst = NO;
         [self.tableView.mj_footer endRefreshing];
     } failure:^(NSError *error) {
         [self.tableView.mj_footer endRefreshing];
     }];
                
}

 #pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YARightPhotoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kYARightPhotoNewsCellIdentifier forIndexPath:indexPath];
    cell.news = self.topicList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kYARightPhotoNewsCellIdentifier cacheByIndexPath:indexPath configuration:^(YARightPhotoNewsCell *cell) {
        cell.news = self.topicList[indexPath.row];
    }];
}

  #pragma mark – Getters and Setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kScreenHeight - 200)];
        [_tableView registerNib:[UINib nibWithNibName:[YARightPhotoNewsCell className] bundle:nil] forCellReuseIdentifier:kYARightPhotoNewsCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray<YARecommendTopicContentListModel *> *)topicList {
    if (!_topicList) {
        _topicList = [NSMutableArray array];
    }
    return _topicList;
}

- (NSMutableArray *)ids {
    if (!_ids) {
        _ids = [NSMutableArray array];
    }
    return _ids;
}
@end
