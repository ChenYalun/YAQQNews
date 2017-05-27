//
//  YARecommendDiscoverViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendDiscoverViewController.h"
#import "YARecommendTopicSection.h"
#import "YARecommendTopicTableViewCell.h"
#import "YANewsRecommendTopicRequest.h"
#import "YARecommendTopicSectionHeaderView.h"

static NSString * const kYARecommendTopicTableViewCellIdentifier = @"YARecommendTopicTableViewCell";

@interface YARecommendDiscoverViewController () <UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <YARecommendTopicSection *> *sections;
@end

@implementation YARecommendDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 搜索栏
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth - 30, 30)];
    searchView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:searchView];
    
    // tableView
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -35, 0);
    YANewsRecommendTopicRequest *request = [[YANewsRecommendTopicRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.sections = [NSArray arrayWithArray:[YARecommendTopicSection topicSectionsWithObject:request.responseObject]];
        
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        kLog(@"%@", request.error);
    }];
}


 #pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].topicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YARecommendTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYARecommendTopicTableViewCellIdentifier forIndexPath:indexPath];
    cell.topic = self.sections[indexPath.section].topicList[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YARecommendTopicSectionHeaderView *view = [YARecommendTopicSectionHeaderView topicSectionHeaderView];
    view.title = self.sections[section].catName;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


 #pragma mark – Getters and Setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.sectionHeaderHeight = 40;
        _tableView.sectionFooterHeight = 0;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerNib:[UINib nibWithNibName:[YARecommendTopicTableViewCell className] bundle:nil] forCellReuseIdentifier:kYARecommendTopicTableViewCellIdentifier];
    }
    return _tableView;
}
@end
