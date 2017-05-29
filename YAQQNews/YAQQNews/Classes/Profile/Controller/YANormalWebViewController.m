//
//  YANormalWebViewController.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/29.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YANormalWebViewController.h"
#import <WebKit/WebKit.h>

@interface YANormalWebViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURL *mainURL;
/** 是否是首次加载 */
@property (nonatomic, assign) BOOL isFirst;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation YANormalWebViewController

 #pragma mark – Life Cycle

- (instancetype)initWithMainURL:(NSURL *)url {
    if (self = [super init]) {
        _mainURL = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isFirst = YES;
    
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.mainURL]];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

 #pragma mark – Events

- (IBAction)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)returnBack:(UIButton *)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self popBack];
    }
}

// 打开分享菜单
- (IBAction)openMenu {
    
}

 #pragma mark – WebView delegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.isFirst) {
        self.isFirst = NO;
    }
    self.titleLabel.text = webView.title;
}

// 在请求开始加载之前调用，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if (!self.isFirst) {
        self.backButton.hidden = NO;
        self.closeButton.hidden = NO;
    }

    decisionHandler(WKNavigationActionPolicyAllow);
    
}


 #pragma mark – Getters and Setters

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
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
        _webView.scrollView.scrollEnabled = YES;
        _webView.scrollView.bounces = YES;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.navigationDelegate = self;
        //_webView.scrollView.zoomScale = 0.9;
    }
    return _webView;
}

@end
