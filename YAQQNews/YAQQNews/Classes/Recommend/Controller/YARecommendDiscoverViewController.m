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

@interface YARecommendDiscoverViewController () <UITableViewDelegate, UITableViewDataSource ,UISearchControllerDelegate,UISearchResultsUpdating>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <YARecommendTopicSection *> *sections;
@end

@implementation YARecommendDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 搜索栏
    
    //创建UISearchController
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    searchController.delegate= self;
    searchController.searchResultsUpdater = self;
    
    // 样式
    searchController.searchBar.searchBarStyle = UIBarStyleBlack;
    
    //包着搜索框外层的颜色
    searchController.searchBar.barTintColor = [UIColor whiteColor];
    // 搜索框内容颜色
    searchController.searchBar.tintColor = [UIColor greenColor];
    // 搜索框背景
    //searchController.searchBar.backgroundImage = ;
    //searchController.searchBar.backgroundColor = [UIColor darkGrayColor];
    // 隐藏搜索按钮
    //searchController.searchBar.showsCancelButton
    
    //提醒字眼

    
    searchController.searchBar.placeholder= @"搜索感兴趣的内容";
    // 文字偏移
   // searchController.searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0, 0);
    //搜索时，背景变暗色
    //searchController.dimsBackgroundDuringPresentation = NO;
    //位置
    searchController.searchBar.frame = CGRectMake(0, 30, kScreenWidth - 60, 30);
    
    // 按钮
    [searchController.searchBar setImage:[[UIImage alloc] init]
                  forSearchBarIcon:UISearchBarIconSearch
                             state:UIControlStateNormal];
    //背景图片
    //[searchController.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_field"] forState:UIControlStateNormal];
    
    // 添加 searchbar 到 headerview
    [self.view addSubview:searchController.searchBar];
    

    
    
    // tableView
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, -20, 0);
    YANewsRecommendTopicRequest *request = [[YANewsRecommendTopicRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.sections = [NSArray arrayWithArray:[YARecommendTopicSection topicSectionsWithObject:request.responseObject]];
        
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        kLog(@"%@", request.error);
    }];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    
}


 #pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].topicList.count;
}

// 调用该方法以解决系统内部section不为0的bug
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
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
        _tableView.sectionFooterHeight = 0;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerNib:[UINib nibWithNibName:[YARecommendTopicTableViewCell className] bundle:nil] forCellReuseIdentifier:kYARecommendTopicTableViewCellIdentifier];
    }
    return _tableView;
}
@end
