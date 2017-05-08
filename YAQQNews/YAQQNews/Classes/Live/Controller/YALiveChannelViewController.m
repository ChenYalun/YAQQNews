//
//  YALiveChannelViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/7.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveChannelViewController.h"
#import "YARefreshHeader.h"
#import "YARefreshFooter.h"
#import "YALiveChannelRequest.h"
#import "YALiveModel.h"
#import "YANewsModel.h"
#import "YAHeaderLabel.h"
#import "YALiveNewsListRequest.h"
#import "YALiveSingleTableViewCell.h"
#import "YALiveGroupTableViewCell.h"


static NSString * const kYALiveSingleTableViewCellIdentifier = @"YALiveSingleTableViewCell";
static NSString * const kYALiveGroupTableViewCellIdentifier = @"YALiveGroupTableViewCell";

@interface YALiveChannelViewController ()
/** 新闻id数组 */
@property (nonatomic, strong) NSMutableArray *ids;
/** 新闻模型 */
@property (nonatomic, strong) NSMutableArray <YANewsModel *> *newsList;
/** tableView头部 */
@property (nonatomic, strong) YAHeaderLabel *headerLabel;
/** 数组分段指针 */
@property (nonatomic, assign) NSUInteger lastIndex;
@end

@implementation YALiveChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self.tableView registerNib:[UINib nibWithNibName:[YALiveSingleTableViewCell className] bundle:nil] forCellReuseIdentifier:kYALiveSingleTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:[YALiveGroupTableViewCell className] bundle:nil] forCellReuseIdentifier:kYALiveGroupTableViewCellIdentifier];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = self.headerLabel;
    
    
    
    self.tableView.mj_header = [YARefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshForNew)];
    self.tableView.mj_footer = [YARefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshForMore)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)refreshForNew {
    YALiveChannelRequest *request = [[YALiveChannelRequest alloc] initWithChannelType:LiveChannelTypeMain];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        // 新闻数组
        NSArray *newsArray = [YALiveModel newsModelWithKeyValuesArray:request.responseObject];
        [self.newsList removeAllObjects];
        [self.newsList addObjectsFromArray:newsArray];
        
        // id数组
        NSArray *idArray = [YALiveModel newsIDsWithresponseObject:request.responseObject];
        [self.ids addObjectsFromArray:idArray];
        
        // 设置id指针
        self.lastIndex = self.newsList.count;
        
        // tableView表头
        self.headerLabel.num = [request.responseObject[@"forecast"][@"num"] unsignedIntegerValue];
        
        [self.tableView reloadData];
        
        //NSLog(@"%@", request.responseString);
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.error);
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }

    }];
    

}

- (void)refreshForMore {
    NSMutableArray *moreNews = [NSMutableArray array];
    NSUInteger pointIndex = self.lastIndex + 20;
    for (; (self.lastIndex < pointIndex) && (self.lastIndex < self.ids.count); self.lastIndex ++) {
        [moreNews addObject:self.ids[self.lastIndex]];
    }
    
    // 数据请求完毕
    if (self.lastIndex >= self.ids.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    // 发送请求
    YALiveNewsListRequest *request = [[YALiveNewsListRequest alloc] initWithChannelType:LiveChannelTypeMain ids:moreNews];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        // 新闻数组
        NSArray *newsArray = [YALiveModel newsModelWithOriginKeyValues:request.responseObject];
        [self.newsList addObjectsFromArray:newsArray];

        
        [self.tableView reloadData];
        
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.error);
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
    }];
    

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsModel *news = self.newsList[indexPath.row];
    if (news.articletype == NewsArticleTypeGroupLive) {
        YALiveGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYALiveGroupTableViewCellIdentifier forIndexPath:indexPath];
        cell.news = news;
        return cell;
    } else {
        YALiveSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYALiveSingleTableViewCellIdentifier forIndexPath:indexPath];
        cell.news = news;
        return cell;
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsModel *news = self.newsList[indexPath.row];
    if (news.articletype == NewsArticleTypeGroupLive) {
        return 145;
    } else {
        return 180;
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
- (NSMutableArray *)ids {
    if (!_ids) {
        _ids = [NSMutableArray array];
    }
    return _ids;
}

- (NSMutableArray *)newsList {
    if (!_newsList) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

- (YAHeaderLabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[YAHeaderLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    }
    return _headerLabel;
}

@end
