//
//  YANewsContentTextViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/12.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANewsContentTextViewController.h"
#import "YANewsModel.h"
#import "YANewsContentRequest.h"
#import "YANewsContent.h"
#import "YANewsContentTitleView.h"
#import <WebKit/WebKit.h>
#import "YANewsShortCommentTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YARightPhotoNewsCell.h"
#import "YANewsContentAttribute.h"
#import <YYWebImageManager.h>
#import "YANotification.h"

@class YANewsComment;

extern CGFloat const kNavigationViewHeight;
extern NSString * const kYARightPhotoNewsCellIdentifier;

static NSString * const kYANewsShortCommentTableViewCellIdentifier = @"YANewsShortCommentTableViewCell";

@interface YANewsContentTextViewController () <WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
/** 新闻模型 */
@property (nonatomic, strong) YANewsModel *news;
/** 标题视图 */
@property (nonatomic, strong) YANewsContentTitleView *titleView;
/** web */
@property (nonatomic, strong) WKWebView *webView;
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** titleView的y */
@property (nonatomic, assign) CGFloat titleViewMaxY;
/** 评论数组 */
@property (nonatomic, strong) NSMutableArray <YANewsComment * > *comments;
/** 相关新闻数组 */
@property (nonatomic, strong) NSMutableArray <YANewsModel * > *newsList;
/** 属性数组 */
@property (nonatomic, strong) NSMutableArray <YANewsContentAttribute * > *attributeArray;
/** 标志位:webView高度已经确定 */
@property (nonatomic, assign) BOOL flag;
@end

@implementation YANewsContentTextViewController

 #pragma mark – Life Cycle

- (instancetype)initWithNews:(YANewsModel *)news {
    if (self = [super init]) {
        _news = news;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // View相关设置
    [self.view addSubview:self.titleView];
    self.tableView.tableHeaderView = self.webView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
   

    
    YANewsContentRequest *request = [[YANewsContentRequest alloc] initWithArticleID:self.news.ID];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        YANewsContent *content = [YANewsContent newsContentWithObject:request.responseObject news:self.news];
        
        // 保存内容属性
        [self.attributeArray addObjectsFromArray:content.attribute];
        
        for (YANewsContentAttribute *attri in content.attribute) {
            NSString *targetString = [NSString stringWithFormat:@"<!--%@-->", attri.name];
            NSData *data = UIImageJPEGRepresentation(kGetImage(@"contentPlaceholder.jpg"), 1.0f);
            NSString *resultString = [NSString stringWithFormat:@"<img id='%@' src='data:image/png;base64,%@' width='%f' height = '%f'/>", attri.name, [data base64Encoding], attri.picWidth,attri.picHeight];
            content.content = [content.content stringByReplacingOccurrencesOfString:targetString withString:resultString];
        }

        [self.webView loadHTMLString:content.content  baseURL:nil];
        
        [self.comments addObjectsFromArray:content.topComments];
        [self.newsList addObjectsFromArray:content.relateNews];
        
        [self.tableView reloadData];
 
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        kLog(@"%@", request.error);
    }];
    
}


/*
// 实时改变webView的控件高度，使其高度跟内容高度一致
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGRect frame = self.webView.frame;
        frame.size.height = self.webView.scrollView.contentSize.height;
        self.webView.frame = frame;
        
        // 很关键
        self.tableView.tableHeaderView = self.webView;

    }
}

- (void)dealloc{
    
    //销毁的时候别忘移除监听
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
 
 */


 #pragma mark – Events

// 转到评论页面
- (void)turnToCommentPage {
    [[NSNotificationCenter defaultCenter] postNotificationName:kYANewsContentTurnPageNotification object:self];
}

 #pragma mark - WKWebViewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 调整webView高度
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        //获取页面高度，并重置webview的frame
        CGFloat height = [result doubleValue];
        webView.height = height + 5;
        self.tableView.tableHeaderView = self.webView;
    }];

    // 获取所有元素位置
    [self.attributeArray enumerateObjectsUsingBlock:^(YANewsContentAttribute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *rectString = [NSString stringWithFormat:@"document.getElementById('%@').getBoundingClientRect().top+document.body.scrollTop", obj.name];
        
        [self.webView evaluateJavaScript:rectString completionHandler:^(id _Nullable value, NSError * _Nullable error) {
            // 保存元素对应的位置
            obj.offsetY = [value floatValue];
            
            if (obj.offsetY - 135 - kScreenHeight < 0  && !obj.hasReplaced) {
                obj.hasReplaced = YES;
                
                [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:obj.origUrl] options:YYWebImageOptionSetImageWithFadeAnimation progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
                    NSString *replaceImageString = [NSString stringWithFormat:@"document.getElementById('%@').src = 'data:image/png;base64,%@'",obj.name, [data base64Encoding]];
                    [self.webView evaluateJavaScript:replaceImageString completionHandler:nil];
                }];
                
            }
        }];
        
    }];

    self.flag = YES;
    



}


 #pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.comments.count;
    } else if(section == 2) {
        return self.newsList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        YANewsShortCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYANewsShortCommentTableViewCellIdentifier forIndexPath:indexPath];
        cell.comment = self.comments[indexPath.row];
        return cell;
    } else if(indexPath.section == 2){
        YARightPhotoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kYARightPhotoNewsCellIdentifier forIndexPath:indexPath];
        YANewsModel *news = self.newsList[indexPath.row];
        // 去除来源
        news.iconTitle = nil;
        cell.news = news;
        return cell;
    }
    return nil;
}

 #pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 1 && self.comments.count > 0) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:@"全部评论" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor darkGrayColor]}] forState:UIControlStateNormal];
        [button setImage:kGetImage(@"icon_view_right") forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 110, 0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        [button addTarget:self action:@selector(turnToCommentPage) forControlEvents:UIControlEventTouchUpInside];
        return button;
    }
    
    return nil;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1 && self.comments.count > 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        label.text = @"－用户热评－";
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    } else if(section == 2 && self.newsList.count > 0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        label.text = @"－相关推荐－";
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    }
    return nil;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return [tableView fd_heightForCellWithIdentifier:kYANewsShortCommentTableViewCellIdentifier cacheByIndexPath:indexPath configuration:^(YANewsShortCommentTableViewCell *cell) {
            cell.comment = self.comments[indexPath.row];
        }];
    } else if(indexPath.section == 2) {
        return [tableView fd_heightForCellWithIdentifier:kYARightPhotoNewsCellIdentifier cacheByIndexPath:indexPath configuration:^(YARightPhotoNewsCell *cell) {
            cell.news = self.newsList[indexPath.row];
        }];
    }
    
    return 0;
}

#pragma mark – ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // titleView透明度的变化与位置的变化
    if (scrollView.contentOffset.y > -self.titleViewMaxY) {
        self.titleView.alpha = 1 - (self.titleViewMaxY + scrollView.contentOffset.y) / self.titleView.height;
        
        CGPoint point = self.titleView.origin;
        point.y = kNavigationViewHeight - (1 - self.titleView.alpha) * 5;
        self.titleView.origin = point;
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 图片的替换
    for (YANewsContentAttribute *attri in self.attributeArray) {
        
        if (attri.offsetY - 100 - kScreenHeight < scrollView.contentOffset.y + 135 && !attri.hasReplaced && self.flag) {
            attri.hasReplaced = YES;
            
            
            [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:attri.origUrl] options:YYWebImageOptionSetImageWithFadeAnimation progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                NSData *data = UIImageJPEGRepresentation(image, 1.0f);
                NSString *replaceImageString = [NSString stringWithFormat:@"document.getElementById('%@').src = 'data:image/png;base64,%@'",attri.name, [data base64Encoding]];
                
                [self.webView evaluateJavaScript:replaceImageString completionHandler:nil];
                
            }];
            
        }
        
    }
}


 #pragma mark – Getters and Setters

-(YANewsContentTitleView *)titleView {
    if (!_titleView) {
        _titleView = [YANewsContentTitleView contentTitleViewWithNews:self.news];
        CGFloat height = _titleView.height;
        _titleView.frame = CGRectMake(0, kNavigationViewHeight, self.view.width - 7, height);
        self.titleViewMaxY = CGRectGetMaxY(self.titleView.frame);
    }
    return _titleView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        // 自适应屏幕宽度js
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *contentController = _webView.configuration.userContentController;
        
        // 添加自适应屏幕宽度js调用的方法
        [contentController addUserScript:wkUserScript];
        
        /*
        //使用kvo为webView添加监听，监听webView的内容高度
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];

         */
        
        
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.navigationDelegate = self;
        //_webView.scrollView.zoomScale = 0.9;
    }
    return _webView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.titleView.frame), 0, 40, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:[YANewsShortCommentTableViewCell className] bundle:nil] forCellReuseIdentifier:kYANewsShortCommentTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:[YARightPhotoNewsCell className] bundle:nil] forCellReuseIdentifier:kYARightPhotoNewsCellIdentifier];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray<YANewsComment *> *)comments {
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}

- (NSMutableArray<YANewsModel *> *)newsList {
    if (!_newsList) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

- (NSMutableArray<YANewsContentAttribute *> *)attributeArray {
    if (!_attributeArray) {
        _attributeArray = [NSMutableArray array];
    }
    return _attributeArray;
}

@end
