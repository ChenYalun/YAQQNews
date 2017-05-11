//
//  YALiveCommentViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveCommentViewController.h"
#import "YALiveCommentTableViewCell.h"
#import "YALiveContentViewController.h"
#import "YARefreshHeader.h"
#import "YARefreshFooter.h"
#import "YALiveCommentRequest.h"
#import "YALiveComment.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YATableViewDataSource.h"

static NSString * const kYACommentTableViewCellIdentifier = @"YALiveCommentTableViewCell";

@interface YALiveCommentViewController ()
/** 评论数组 */
@property (nonatomic, strong) NSMutableArray <YALiveComment *> *comments;
/** articleID */
@property (nonatomic, copy) NSString *articleID;
@end

@implementation YALiveCommentViewController

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo {
    if (self = [super init]) {
        _articleID = userInfo[@"articleID"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // tableView 配置
    self.tableView.separatorColor = kRGBAColor(217, 217, 217, 0.3);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.tableView registerNib:[UINib nibWithNibName:[YALiveCommentTableViewCell className] bundle:nil] forCellReuseIdentifier:kYACommentTableViewCellIdentifier];

    
    // 发送数据更新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveComments:) name:@"NotificationComments" object:nil];
    
    self.tableView.mj_footer = [YARefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshForMore)];
    self.tableView.mj_header = [YARefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshForNew)];
    
}

 #pragma mark – Events

- (void)refreshForNew {
    [self refreshForDataWithMore:NO];
}

- (void)refreshForMore {
    [self refreshForDataWithMore:YES];
}

- (void)refreshForDataWithMore:(BOOL)isForMore {
    NSString *lastID = [NSString string];
    
    if (isForMore) {
        lastID = self.comments.lastObject.ID;
    }
    
    YALiveCommentRequest *request = [[YALiveCommentRequest alloc] initWithArticleID:self.articleID lastID:lastID];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSArray *array = [YALiveComment liveCommentWithObject:request.responseObject];
        
        // 数据加载完毕
        if (array.count <= 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        if (!isForMore) {
            // 取出置顶评论
            NSMutableArray *topArray = [NSMutableArray array];
            for (YALiveComment *comment in self.comments) {
                if (comment.isStick) {
                    [topArray addObject:comment];
                }
            }
            [self.comments removeAllObjects];
            [self.comments addObjectsFromArray:topArray];
        }
        
        [self.comments addObjectsFromArray:array];
        [self.tableView reloadData];
        
        if ([self.tableView.mj_footer isRefreshing] || [self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if ([self.tableView.mj_footer isRefreshing] || [self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        }
    }];

}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kYACommentTableViewCellIdentifier cacheByIndexPath:indexPath configuration:^(YALiveCommentTableViewCell *cell) {
        cell.comment = self.comments[indexPath.row];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YALiveCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYACommentTableViewCellIdentifier forIndexPath:indexPath];
    cell.comment = self.comments[indexPath.row];
    return cell;
}


- (void)receiveComments:(NSNotification *)notification {
    [self setComments:notification.userInfo[@"comments"]];
}

- (void)setComments:(NSMutableArray *)comments {
    _comments = [NSMutableArray array];
    [_comments addObjectsFromArray:comments];
    
    [self.tableView reloadData];
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

@end
