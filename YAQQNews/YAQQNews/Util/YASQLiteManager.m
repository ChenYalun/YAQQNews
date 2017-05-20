//
//  YASQLiteManager.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/20.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YASQLiteManager.h"

@implementation YASQLiteManager
#pragma mark - life Cycle

+ (instancetype)sharedManager {
    static YASQLiteManager *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[super  allocWithZone:NULL] init];
        
        // 拼接数据库路径
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *dbPath = [path stringByAppendingPathComponent:@"news.db"];
        //  执行SQL语句
        manager.queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [manager.queue inDatabase:^(FMDatabase *db) {
            [db open];
            [manager createNewsTable:db];
            
        }];
        
    });
    
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [YASQLiteManager sharedManager];
}

- (id)copy {
    return [YASQLiteManager sharedManager];
}

- (id)mutableCopy {
    return [YASQLiteManager sharedManager];
}

#pragma mark - private method

// 创建新闻列表
- (void)createNewsTable:(FMDatabase *)dataBase {
    
    // 获取sql命令位置
    NSString *sqlPath  = [[NSBundle mainBundle] pathForResource:@"t_newsList" ofType:@"sql"];
    
    // 加载表中的内容
    NSString *sql = [NSString stringWithContentsOfFile:sqlPath encoding:NSUTF8StringEncoding error:nil];
    
    // 执行sql语句
    if ([dataBase executeStatements:sql]) {
        kLog(@"执行SQL成功");
    };
}
@end
