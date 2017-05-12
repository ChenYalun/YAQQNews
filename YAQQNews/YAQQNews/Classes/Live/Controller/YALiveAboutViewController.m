//
//  YALiveAboutViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/11.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveAboutViewController.h"
#import "YALiveAboutTableHeaderView.h"
#import "YALiveCommentRequest.h"
#import "YARightPhotoNewsCell.h"
#import "YANewsModel.h"
#import "YANotification.h"

static NSString * const kYARightPhotoNewsCellIdentifier = @"YARightPhotoNewsCell";

@interface YALiveAboutViewController ()
/** 相关新闻 */
@property (nonatomic, strong) NSMutableArray <YANewsModel *> *relateNews;
/** 简介 */
@property (nonatomic, copy) NSString *desc;

@end

@implementation YALiveAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 发送数据更新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNews:) name:kYALiveContentNotification object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:[YARightPhotoNewsCell className] bundle:nil] forCellReuseIdentifier:kYARightPhotoNewsCellIdentifier];
    self.tableView.tableHeaderView = [[YALiveAboutTableHeaderView alloc] initWithDesc:self.desc];
    self.tableView.rowHeight = 100;
    
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveNews:(NSNotification *)notification {
    [self.relateNews addObjectsFromArray:notification.userInfo[@"relateNews"]];
    
    // 去除冗余数据
    for (YANewsModel *news in self.relateNews) {
        news.source = nil;
        news.isLive = YES;
        news.iconColor = @"#bcbcbc";
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.relateNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YARightPhotoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kYARightPhotoNewsCellIdentifier forIndexPath:indexPath];
    cell.news = self.relateNews[indexPath.row];
    return cell;
}



 #pragma mark – Getters and Setters
- (NSMutableArray<YANewsModel *> *)relateNews {
    if (!_relateNews) {
        _relateNews = [NSMutableArray array];
    }
    return _relateNews;
}
@end
