//
//  YARecommendTopicSubscribeViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YARecommendTopicSubscribeViewController.h"
#import "YARecommendTopicContentListModel.h"
#import "YARefreshFooter.h"
#import "YARightPhotoNewsCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YARecommendInterestModel.h"
#import "YARecommendTopicContentListModel.h"
#import <UIImageView+YYWebImage.h>
#import "UIImage+YARenderingMode.h"
#import "YANewsContentViewController.h"

static NSUInteger count = 20;

static NSString * const kYARightPhotoNewsCellIdentifier = @"YARightPhotoNewsCell";

@interface YARecommendTopicSubscribeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *idenfifierImageView;

@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet UILabel *naviTitleLabel;

/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 话题类型 */
@property (nonatomic, strong) YARecommendInterestModel *interest;
/** 话题数组 */
@property (nonatomic, strong) NSMutableArray <YARecommendTopicContentListModel *> *topicList;
/** 新闻列表ID */
@property (nonatomic, strong) NSMutableArray *ids;
/** 数组截取位置 */
@property (nonatomic, assign) NSUInteger loc;
@end

@implementation YARecommendTopicSubscribeViewController

#pragma mark – Life Cycle

- (instancetype)initWithInterestModel:(YARecommendInterestModel *)interest {
    if (self = [super init]) {
        _interest = interest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    // 头像
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:self.interest.icon] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        self.iconImageView.image = [UIImage imageToRoundImageWithImage:image];
        
    }];
    // 标题
    self.titleLabel.text = self.interest.title;
    // 关注
    self.subLabel.text = self.interest.subString;
    // 发布
    self.pubLabel.text = self.interest.pubString;
    // 头部标题
    self.naviTitleLabel.text = self.interest.title;

    [YARecommendTopicContentListModel loadIDArrayWithChildID:self.interest.ID completionBlockWithSuccess:^(NSArray<YARecommendTopicContentListModel *> *topicList, NSArray <NSString *> *ids) {
        [self.ids addObjectsFromArray:ids];
        self.loc = topicList.count;
        [self.topicList addObjectsFromArray:topicList];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    

    self.tableView.mj_footer = [YARefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshForMore)];
//    [self.tableView.mj_footer beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark – Events

// 上拉加载
- (void)refreshForMore {

    NSUInteger len = 0;
    if (self.loc + count  <= self.ids.count) {
        len = count;
    } else if(self.ids.count <= count) { // 首次加载出现count 比 id数组长度小
        len = self.ids.count;
    } else{
        len = self.ids.count - self.loc;
    }
    
    NSArray *array = [self.ids subarrayWithRange:NSMakeRange(self.loc, len)];
    [YARecommendTopicContentListModel loadTopicSubscribeListWithIDArray:array completionBlockWithSuccess:^(NSArray<YARecommendTopicContentListModel *> *topicList) {
        if (topicList.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.topicList addObjectsFromArray:topicList];
        self.loc += len;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}

- (IBAction)popBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YARightPhotoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kYARightPhotoNewsCellIdentifier forIndexPath:indexPath];
    cell.news = self.topicList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kYARightPhotoNewsCellIdentifier cacheByIndexPath:indexPath configuration:^(YARightPhotoNewsCell *cell) {
        cell.news = self.topicList[indexPath.row];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YANewsModel *news = (YANewsModel *)self.topicList[indexPath.row];
    if (news.articletype == NewsArticleTypeNormal) {
        YANewsContentViewController *contentViewController = [[YANewsContentViewController alloc] initWithNews:news];
        [self.navigationController pushViewController:contentViewController animated:YES];
    }
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y + 64;

    // 衔接
    self.headerViewTopConstraint.constant = 64 - y;
    
    // 渐变
    if (y > 0 && y <= 50) {
        self.navigationView.backgroundColor = kRGBAColor(48, 122, 212, 1 - y / 50.0);
        self.headerView.backgroundColor = kRGBAColor(48, 122, 212, 1 - y / 50.0);
    }
    
    // 替换
    if (y > 35) {
        self.iconImageView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.subLabel.hidden = YES;
        self.pubLabel.hidden = YES;
        self.idenfifierImageView.hidden = YES;
        self.naviTitleLabel.hidden = NO;
        [self.returnButton setImage:kGetImage(@"navbar_icon_back_normal") forState:UIControlStateNormal];
        [self.subButton setImage:kGetImage(@"follow_bt_word_normal_black") forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    } else {
        self.iconImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.subLabel.hidden = NO;
        self.pubLabel.hidden = NO;
        self.idenfifierImageView.hidden = NO;
        self.naviTitleLabel.hidden = YES;
        [self.returnButton setImage:kGetImage(@"navbar_icon_white_back_normal") forState:UIControlStateNormal];
        [self.subButton setImage:kGetImage(@"follow_bt_word_normal") forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
}
#pragma mark – Getters and Setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 60, 0);
        [_tableView registerNib:[UINib nibWithNibName:[YARightPhotoNewsCell className] bundle:nil] forCellReuseIdentifier:kYARightPhotoNewsCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view insertSubview:_tableView atIndex:0];
    }
    return _tableView;
}

- (NSMutableArray<YARecommendTopicContentListModel *> *)topicList {
    if (!_topicList) {
        _topicList = [NSMutableArray array];
    }
    return _topicList;
}

- (NSMutableArray *)ids {
    if (!_ids) {
        _ids = [NSMutableArray array];
    }
    return _ids;
}
@end
