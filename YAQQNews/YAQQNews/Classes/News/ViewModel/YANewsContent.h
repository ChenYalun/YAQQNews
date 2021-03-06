//
//  YANewsContent.h
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YANewsModel, YANewsComment, YANewsContentAttribute;

@interface YANewsContent : NSObject
/** 文章ID */
@property (nonatomic, copy) NSString *ID;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 来源 */
@property (nonatomic, copy) NSString *source;
/** 时间 */
@property (nonatomic, copy) NSString *time;

/** 所有图片的url地址集合 */
@property (nonatomic, strong) NSMutableArray *picURLs;
/** 正文 */
@property (nonatomic, copy) NSString *content;
/** FadCid */
@property (nonatomic, copy) NSString *FadCid;
/** intro摘要 */
@property (nonatomic, copy) NSString *intro;
/** 结语 */
@property (nonatomic, copy) NSString *remarks;
/** 评论标题 */
@property (nonatomic, copy) NSString *commentTitle;
/** 图片视频 */
@property (nonatomic, strong) NSMutableArray <YANewsContentAttribute *> * attribute;
/** 相关新闻 */
@property (nonatomic, copy) NSArray <YANewsModel *> *relateNews;
/** 置顶评论 */
@property (nonatomic, copy) NSArray <YANewsComment *> *topComments;

// 提供快速字典转模型
+ (YANewsContent *)newsContentWithObject:(id)object news:(YANewsModel *)news;

@end

