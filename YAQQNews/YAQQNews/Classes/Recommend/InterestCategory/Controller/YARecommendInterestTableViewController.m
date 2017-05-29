//
//  YARecommendInterestTableViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendInterestTableViewController.h"
#import "YARecommendInterestTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YARecommendTopicContentViewController.h"
#import "YARecommendInterestModel.h"
#import "YARefreshFooter.h"
#import "YARecommendTopicSubscribeViewController.h"

static NSString * const kYARecommendInterestTableViewCellIdentifier = @"YARecommendInterestTableViewCell";

@interface YARecommendInterestTableViewController ()
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray <YARecommendInterestModel *> *interestList;
/** 页码 */
@property (nonatomic, assign) NSUInteger page;
@end

@implementation YARecommendInterestTableViewController

 #pragma mark – Life Cycle

- (instancetype)initWithInterestModelArray:(NSArray <YARecommendInterestModel *> *)array {
    if (self = [super init]) {
        self.interestList = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:[YARecommendInterestTableViewCell className] bundle:nil] forCellReuseIdentifier:kYARecommendInterestTableViewCellIdentifier];
    self.tableView.separatorColor = kRGBColor(235, 235, 235);
    UIEdgeInsets edge = self.tableView.contentInset;
    edge.bottom = 64;
    self.tableView.contentInset = edge;
    
    self.tableView.mj_footer = [YARefreshFooter  footerWithRefreshingTarget:self refreshingAction:@selector(refreshForMore)];
    [self.tableView.mj_footer beginRefreshing];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

 #pragma mark – Events

- (void)refreshForMore {
    [YARecommendInterestModel loadMoreInterestWithPage:self.page catID:[[[[YARecommendInterestModel alloc] init] catIDForNameDictionary] objectForKey:self.title]  completionBlockWithSuccess:^(NSArray<YARecommendInterestModel *> *interestList) {
        // 没有更多数据
        if (interestList.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.interestList addObjectsFromArray:interestList];
        [self.tableView reloadData];
        self.page += 1;
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.interestList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YARecommendInterestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYARecommendInterestTableViewCellIdentifier forIndexPath:indexPath];
    cell.interest = self.interestList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView fd_heightForCellWithIdentifier:kYARecommendInterestTableViewCellIdentifier cacheByIndexPath:indexPath configuration:^(YARecommendInterestTableViewCell *cell) {
        cell.interest = self.interestList[indexPath.row];
        }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.interestList[indexPath.row].isSubType) {
        YARecommendTopicSubscribeViewController *viewController = [[YARecommendTopicSubscribeViewController alloc] initWithInterestModel:self.interestList[indexPath.row]];
        
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        YARecommendTopicContentViewController *viewController = [[YARecommendTopicContentViewController alloc] initWithTopicID:self.interestList[indexPath.row].ID];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

 #pragma mark – Getters and Setters

- (NSMutableArray<YARecommendInterestModel *> *)interestList {
    if (!_interestList) {
        _interestList = [NSMutableArray array];
    }
    return _interestList;
}

@end
