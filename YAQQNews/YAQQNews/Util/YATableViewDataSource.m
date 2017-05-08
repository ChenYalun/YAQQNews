//
//  YATableViewDataSource.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/8.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YATableViewDataSource.h"

@interface YATableViewDataSource ()
/** 数据数组 */
@property (nonatomic,strong) NSMutableArray *items;
/** 重用ID */
@property (nonatomic,copy) NSString *cellIdentifier;
/** 回调block */
@property (nonatomic,copy) configureCell block;
@end
@implementation YATableViewDataSource


- (instancetype)initWithItems:(NSMutableArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(configureCell)block {
    if (self = [super init]) {
        _items = items;
        _block = block;
        _cellIdentifier = cellIdentifier;
    }
    return self;
}


#pragma mark – Private Methods
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return _items[(NSUInteger)indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    _block(cell, item);
    return cell;
}

@end
