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
#import "YALiveHeaderLabel.h"
#import "YALiveNewsListRequest.h"
#import "YALiveChannelDataSource.h"


static NSString * const kYALiveSingleTableViewCellIdentifier = @"YALiveSingleTableViewCell";
static NSString * const kYALiveGroupTableViewCellIdentifier = @"YALiveGroupTableViewCell";

@interface YALiveChannelViewController ()

/** tableView头部 */
@property (nonatomic, strong) YALiveHeaderLabel *headerLabel;
/** tableView数据源 */
@property (nonatomic, strong) YALiveChannelDataSource *dataSource;
@end

@implementation YALiveChannelViewController

- (instancetype)initWithChannelType:(LiveChannelType)type {
    if (self = [super init]) {
        _channelType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YALiveSingleTableViewCell" bundle:nil] forCellReuseIdentifier:kYALiveSingleTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"YALiveGroupTableViewCell" bundle:nil] forCellReuseIdentifier:kYALiveGroupTableViewCellIdentifier];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = self.headerLabel;
    
    
    self.tableView.mj_header = [YARefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshForNew)];
    self.tableView.mj_footer = [YARefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshForMore)];
    
    [self.tableView.mj_header beginRefreshing];
    
    
}


- (void)refreshForNew {
    YALiveChannelRequest *request = [[YALiveChannelRequest alloc] initWithChannelType:self.channelType];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.dataSource afterRefreshForNew:request.responseObject];
        // tableView表头
        self.headerLabel.num = [request.responseObject[@"forecast"][@"num"] unsignedIntegerValue];
        // 没有直播预告时置为空
        if (self.headerLabel.num == 0) {
            self.tableView.tableHeaderView = nil;
        }
        
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

    
    NSArray *moreNews =  [self.dataSource beforeRefreshForMore];
    
    // 发送请求
    if (!moreNews) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    YALiveNewsListRequest *request = [[YALiveNewsListRequest alloc] initWithChannelType:self.channelType ids:moreNews];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ;
        
        [self.dataSource afterRefreshForMore:request.responseObject];
        
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

- (YALiveHeaderLabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[YALiveHeaderLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    }
    return _headerLabel;
}
- (YALiveChannelDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[YALiveChannelDataSource alloc] init];
    }
    return _dataSource;
}
@end
