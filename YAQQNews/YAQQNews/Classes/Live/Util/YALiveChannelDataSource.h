//
//  YALiveChannelDataSource.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YALiveChannelDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
- (void)afterRefreshForNew:(id)responseObject;
- (void)afterRefreshForMore:(id)responseObject;
- (NSArray *)beforeRefreshForMore;
@end
