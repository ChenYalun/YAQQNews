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

static NSString * const kYANewsCommentTableViewCell = @"YANewsCommentTableViewCell";

@interface YANewsContentCommentViewController ()
/** 新闻模型 */
@property (nonatomic, strong) YANewsModel *news;

/** 热门评论 */
@property (nonatomic, strong) NSMutableArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *comments;

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
    
    self.view.backgroundColor = [UIColor redColor];

    [self.tableView registerNib:[UINib nibWithNibName:@"YANewsCommentTableViewCell" bundle:nil] forCellReuseIdentifier:kYANewsCommentTableViewCell];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYANewsCommentTableViewCell forIndexPath:indexPath];
    
    cell.comment = self.hotComments[indexPath.row];
    
    return cell;
}

@end
