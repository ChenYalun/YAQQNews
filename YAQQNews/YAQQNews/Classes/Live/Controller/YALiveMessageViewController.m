//
//  YALiveMessageViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/10.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveMessageViewController.h"
#import "YALiveMessage.h"
#import "YALiveMessageTableViewCell.h"
#import "YALiveMessageRequest.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YALiveRefreshFooter.h"
#import "YANews.h"

static NSString * const kYALiveMessageTableViewCellIdentifier = @"YALiveMessageTableViewCell";

@interface YALiveMessageViewController ()
@property (nonatomic, strong) NSMutableArray <YALiveMessage *> *messageArray;
/** articleID */
@property (nonatomic, copy) NSString *articleID;
/** 最后一个messageID */
@property (nonatomic, copy) NSString *lastReplyID;
/** 评论ID */
@property (nonatomic, copy) NSString *commentID;
/** 页面类型 */
@property (nonatomic, assign) NewsArticleType articleTye;
@end

@implementation YALiveMessageViewController

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo {
    if (self = [super init]) {
        _articleID = userInfo[@"articleID"];
        _commentID = userInfo[@"commentID"];
        _articleTye = [userInfo[@"type"] integerValue];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // tableView逆置
    self.tableView.transform = CGAffineTransformMakeScale(1, -1);
    
    [self.tableView registerNib:[UINib nibWithNibName:[YALiveMessageTableViewCell className] bundle:nil] forCellReuseIdentifier:kYALiveMessageTableViewCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(49, 0, 0, 0);

    self.tableView.mj_footer = [YALiveRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshForData)];
    [self.tableView.mj_footer beginRefreshing];
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //[self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX) animated:YES];

}

- (void)refreshForData {
    // 首次请求
    if (!self.lastReplyID) {
        self.lastReplyID = [NSString string];
    }
    

    
    YALiveMessageRequest *request = [[YALiveMessageRequest alloc] initWithArticleID:self.articleID aboutPageCommentID:self.commentID replyID:self.lastReplyID articleType:self.articleTye];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (self.articleTye == NewsArticleTypeAboutLive) { // 关于页面的请求
            NSArray <YALiveMessage *> *array = [YALiveMessage liveMessageWithKeyValues:request.responseObject];
            self.lastReplyID = array.firstObject.replyID;
            [self.messageArray addObjectsFromArray:array];
        } else { // 主播页面的请求
            NSArray <YALiveMessage *> *array = [YALiveMessage liveMessageWithObject:request.responseObject];
            self.lastReplyID = array.firstObject.replyID;
            [self.messageArray addObjectsFromArray:array];
        }
        
        [self.tableView reloadData];

        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        NSLog(@"%@", request.error);
    }];

}
 -(void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self];
                                         
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YALiveMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYALiveMessageTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.message = self.messageArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kYALiveMessageTableViewCellIdentifier cacheByIndexPath:indexPath configuration:^(YALiveMessageTableViewCell *cell) {
        cell.message = self.messageArray[indexPath.row];
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
- (NSMutableArray <YALiveMessage *> *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}

@end
