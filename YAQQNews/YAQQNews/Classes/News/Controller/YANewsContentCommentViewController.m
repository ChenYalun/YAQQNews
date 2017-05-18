//
//  YANewsContentCommentViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContentCommentViewController.h"
#import "YANewsCommentTableViewCell.h"
#import "YANewsModel.h"
#import "YANewsComment.h"
#import "YANewsCommentRequest.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YANewsContentTitleView.h"
#import "YANewsContentAttributeView.h"
#import "YARefreshFooter.h"

static NSString * const kYANewsCommentTableViewCell = @"YANewsCommentTableViewCell";

@interface YANewsContentCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/** 新闻模型 */
@property (nonatomic, strong) YANewsModel *news;
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 头部标题 */
@property (nonatomic, strong) YANewsContentTitleView *titleView;
/** 热门评论 */
@property (nonatomic, strong) NSMutableArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *mainComments;
/** 页码 */
@property (nonatomic, assign) NSUInteger page;
/** 表情数据字典 */
@property (nonatomic, strong) NSDictionary *attribute;
/** 表情View */
@property (nonatomic, strong) YANewsContentAttributeView *attributeView;
/** 评论总数 */
@property (nonatomic, assign) NSUInteger commentsCount;
@end

@implementation YANewsContentCommentViewController

 #pragma mark – Life Cycle

- (instancetype)initWithNews:(YANewsModel *)news {
    if (self = [super init]) {
        _news = news;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.mj_footer = [YARefreshFooter footerWithRefreshingBlock:^{
        YANewsCommentRequest *request = [[YANewsCommentRequest alloc] initWithCommentID:self.news.commentid page:++self.page];
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            if ([self.tableView.mj_footer isRefreshing]) {
                [self.tableView.mj_footer endRefreshing];
            }
            
        
            [self.hotComments addObjectsFromArray:[YANewsComment hotCommentsWithObject:request.responseObject]];
            
            NSArray *array = [YANewsComment newCommentsWithObject:request.responseObject];
            if (array.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.mainComments addObjectsFromArray:array];
            self.attribute = [YANewsComment exprInfoInComments:request.responseObject];
            self.commentsCount = [YANewsComment commentsCount:request.responseObject];
            
            if (self.attribute.count == 0) {
                self.tableView.tableHeaderView = self.titleView;
            } else {
                self.attributeView.attribute = self.attribute;
            }
            
            
            
            [self.tableView reloadData];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            if ([self.tableView.mj_footer isRefreshing]) {
                [self.tableView.mj_footer endRefreshing];
            }
            
            kLog(@"%@", request.error);
        }];
    }];

    [self.tableView.mj_footer beginRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count;
    } else {
        return self.mainComments.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYANewsCommentTableViewCell forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.comment = self.hotComments[indexPath.row];
    } else {
        cell.comment = self.mainComments[indexPath.row];
    }

    return cell;
}
 #pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:kYANewsCommentTableViewCell cacheByIndexPath:indexPath configuration:^(YANewsCommentTableViewCell *cell) {
            cell.comment = self.hotComments[indexPath.row];
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:kYANewsCommentTableViewCell cacheByIndexPath:indexPath configuration:^(YANewsCommentTableViewCell *cell) {
            cell.comment = self.mainComments[indexPath.row];
        }];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 && self.hotComments.count > 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width, 20)];
        [view addSubview:label];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.text = [NSString stringWithFormat:@"热门评论(%lu)", (unsigned long)self.hotComments.count];
        
        return view;
    }
    if (section == 1 && self.mainComments.count > 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width, 20)];
        [view addSubview:label];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.text = [NSString stringWithFormat:@"最新评论(%lu)", (unsigned long)self.commentsCount];
        return view;
    }
    
    return nil;
}
 #pragma mark – Getters and Setters

- (NSMutableArray *)hotComments {
    if (!_hotComments) {
        _hotComments = [NSMutableArray array];
    }
    return _hotComments;
}

- (NSMutableArray *)mainComments {
    if (!_mainComments) {
        _mainComments = [NSMutableArray array];
    }
    return _mainComments;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:[YANewsCommentTableViewCell className] bundle:nil] forCellReuseIdentifier:kYANewsCommentTableViewCell];
        _tableView.contentInset = UIEdgeInsetsMake(15, 0, 75, 0);
        _tableView.separatorColor = kRGBAColor(240, 240, 240, 0.8);
        self.titleView.width = self.view.width - 20;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.titleView.height + self.attributeView.height)];
        [headerView addSubview:self.titleView];
        [headerView addSubview:self.attributeView];
        self.attributeView.origin = CGPointMake(0, self.titleView.height);
        
        _tableView.tableHeaderView = headerView;;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (YANewsContentTitleView *)titleView {
    if (!_titleView) {
        _titleView = [YANewsContentTitleView contentTitleViewWithNews:self.news];
    }
    return _titleView;
}

- (YANewsContentAttributeView *)attributeView {
    if (!_attributeView) {
        _attributeView = [YANewsContentAttributeView contentAttributeTitleView];
        
    }
    return _attributeView;
}

@end
