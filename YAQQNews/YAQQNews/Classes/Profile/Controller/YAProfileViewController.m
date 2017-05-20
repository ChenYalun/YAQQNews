//
//  YAProfileViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAProfileViewController.h"
#import "YAProfileTableViewCell.h"
#import "YAProfileDetail.h"
#import "YAProfileTableHeaderView.h"

NSString * const kYAProfileTableViewCellIdentifier = @"YAProfileTableViewCell";

@interface YAProfileViewController () <UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray <YAProfileDetail *> *detailList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewTopConstraint;
@end

@implementation YAProfileViewController

#pragma mark – Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.detailList = [YAProfileDetail profileDetail];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YAProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYAProfileTableViewCellIdentifier forIndexPath:indexPath];
    cell.detail = self.detailList[indexPath.row];
    return cell;
}

 #pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= -200) {
        self.iconViewTopConstraint.constant = 60 - (scrollView.contentOffset.y + 200);
    }
    
    if (scrollView.contentOffset.y < -200) {
        
        self.iconViewTopConstraint.constant = 60 + (-scrollView.contentOffset.y - 200) * 0.8;
    }
    
    if (scrollView.contentOffset.y < -300) {
        scrollView.contentOffset = CGPointMake(0, -300);
    }
    
}

#pragma mark – Getters and Setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.rowHeight = 45;
        _tableView.separatorColor = kRGBAColor(240, 240, 240, 0.5);
        _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:[YAProfileTableViewCell className] bundle:nil] forCellReuseIdentifier:kYAProfileTableViewCellIdentifier];
        _tableView.showsVerticalScrollIndicator = YES;
        // headView
        YAProfileTableHeaderView *headView = [YAProfileTableHeaderView profileTableHeaderView];
        _tableView.tableHeaderView = headView;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
