//
//  YALiveChannelDataSource.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveChannelDataSource.h"
#import "YALiveSingleTableViewCell.h"
#import "YALiveGroupTableViewCell.h"
#import "YALiveModel.h"
#import "YANewsModel.h"


static NSString * const kYALiveSingleTableViewCellIdentifier = @"YALiveSingleTableViewCell";
static NSString * const kYALiveGroupTableViewCellIdentifier = @"YALiveGroupTableViewCell";


@interface YALiveChannelDataSource () 
/** 新闻id数组 */
@property (nonatomic, strong) NSMutableArray *ids;
/** 新闻模型 */
@property (nonatomic, strong) NSMutableArray <YANewsModel *> *newsList;
/** 数组分段指针 */
@property (nonatomic, assign) NSUInteger lastIndex;
@end
@implementation YALiveChannelDataSource

- (void)afterRefreshForNew:(id)responseObject {
    // 新闻数组
    NSArray *newsArray = [YALiveModel newsModelWithKeyValuesArray:responseObject];
    [self.newsList removeAllObjects];
    [self.newsList addObjectsFromArray:newsArray];
    
    // id数组
    NSArray *idArray = [YALiveModel newsIDsWithresponseObject:responseObject];
    [self.ids addObjectsFromArray:idArray];
    
    // 设置id指针
    self.lastIndex = self.newsList.count;

}
- (void)afterRefreshForMore:(id)responseObject {
    // 新闻数组
    NSArray *newsArray = [YALiveModel newsModelWithOriginKeyValues:responseObject];
    [self.newsList addObjectsFromArray:newsArray];
    
}
- (NSArray *)beforeRefreshForMore {
    NSMutableArray *moreNews = [NSMutableArray array];
    NSUInteger pointIndex = self.lastIndex + 20;
    for (; (self.lastIndex < pointIndex) && (self.lastIndex < self.ids.count); self.lastIndex ++) {
        [moreNews addObject:self.ids[self.lastIndex]];
    }
    
    // 数据请求完毕
    if (self.lastIndex >= self.ids.count) {
        return nil;
    }
    
    return moreNews;
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

@end
