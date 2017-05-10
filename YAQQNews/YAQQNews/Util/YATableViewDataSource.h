//
//  YATableViewDataSource.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/8.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YATableViewDataSource : NSObject <UITableViewDataSource>
// 回调block
typedef void(^configureCell) (UITableViewCell *cell, id model);

// 便捷构造方法
- (instancetype)initWithItems:(NSMutableArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(configureCell)block;
@end
