//
//  ApeWebController.m
//  Youhu
//
//  Created by Eton on 2016/10/25.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeWebController.h"
#import <WebKit/WebKit.h>

//WKWeb刷17dhw页面时，无法调整
#define Is_User_WKWeb [NSNumber numberWithBool:NO].boolValue //IS_GREATER_EQUAL_IOS(8.0)
#define WebViewNav_TintColor ([UIColor whiteColor])
#define WebViewNav_ProgressColor SUBJECT_COLOR

@interface ApeWebController ()<UIWebViewDelegate,UIActionSheetDelegate,WKNavigationDelegate>
@property (assign, nonatomic) NSUInteger loadCount;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) WKWebView *wkWebView;

@end

@implementation ApeWebController


/** 传入控制器、url、标题 */
+ (void)pushWithController:(UIViewController *)contro withUrlStr:(NSString *)urlStr withTitle:(NSString *)title {
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:urlStr] invertedSet];
//    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];

    ApeWebController *webContro = [[ApeWebController alloc] init];
    webContro.homeUrl = [NSURL URLWithString:urlStr];
    webContro.title = title;
    [contro.navigationController pushViewController:webContro animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configUI];
    
//    if (self.navigationController.viewControllers.count > 1) {
        [self crateBackButton];
//    }
    //    [self configMenuItem];
    
}

- (void)setHomeUrl:(NSURL *)homeUrl{
    _homeUrl = homeUrl;
    
    NSLog(@"HomeUrl:%@ \n",homeUrl);
    NSURLRequest *request = [NSURLRequest requestWithURL:_homeUrl];
    if (Is_User_WKWeb) {
        if (self.wkWebView) {
            [self.wkWebView loadRequest:request];
        }
    }else {
        if (self.webView) {
            [self.webView loadRequest:request];
        }
    }
}

- (void)configUI {
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    progressView.tintColor = WebViewNav_ProgressColor;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    // 网页
    if (Is_User_WKWeb) {
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 0)];
        wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        wkWebView.backgroundColor = [UIColor whiteColor];
        wkWebView.navigationDelegate = self;
        [self.view insertSubview:wkWebView belowSubview:progressView];
        
        [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:_homeUrl];
        [wkWebView loadRequest:request];
        self.wkWebView = wkWebView;
    }else {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 0)];
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        webView.scalesPageToFit = YES;
        webView.backgroundColor = [UIColor whiteColor];
        webView.delegate = self;
        [self.view insertSubview:webView belowSubview:progressView];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:_homeUrl];
        [webView loadRequest:request];
        self.webView = webView;
    }
}

- (void)configColseItem {
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *colseBtn = [self addLeftBarText:@"关闭" image:nil action:@selector(colseBtnPressed:)];
        if (appTarget == AppTarget_Youhu) {
            [colseBtn setTitleColor:WebViewNav_TintColor forState:UIControlStateNormal];
        }else if (appTarget == AppTarget_Apestar) {
            [colseBtn setTitleColor:SUBJECT_COLOR forState:UIControlStateNormal];
        }else if (appTarget == AppTarget_Joke) {
            [colseBtn setTitleColor:SUBJECT_COLOR forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 普通按钮事件

// 返回按钮点击
- (void)back{
    if (Is_User_WKWeb) {
        if (self.wkWebView.canGoBack) {
            [self.wkWebView goBack];
            if (self.navigationItem.leftBarButtonItems.count == 2) {
                [self configColseItem];
            }
        }else {
            [super back];
        }
    }else {
        if (self.webView.canGoBack) {
            [self.webView goBack];
            if (self.navigationItem.leftBarButtonItems.count == 2) {
                [self configColseItem];
            }
        }else {
            [super back];
        }
    }
}

// 菜单按钮点击
- (void)menuBtnPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"safari打开",@"复制链接",@"分享",@"刷新", nil];
    [actionSheet showInView:self.view];
}

// 关闭按钮点击
- (void)colseBtnPressed:(id)sender {
    [super back];
}

#pragma mark - 菜单按钮事件

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSString *urlStr = _homeUrl.absoluteString;
    if (Is_User_WKWeb) urlStr = self.wkWebView.URL.absoluteString;
    else urlStr = self.webView.request.URL.absoluteString;
    if (buttonIndex == 0) {
        
        // safari打开
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }else if (buttonIndex == 1) {
        
        // 复制链接
        if (urlStr.length > 0) {
            [[UIPasteboard generalPasteboard] setString:urlStr];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"已复制链接到黏贴板" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alertView show];
        }
    }else if (buttonIndex == 2) {
        
        // 分享
        //[self.wkWebView evaluateJavaScript:@"这里写js代码" completionHandler:^(id reponse, NSError * error) {
        //NSLog(@"返回的结果%@",reponse);
        //}];
        NSLog(@"这里自己写，分享url：%@",urlStr);
    }else if (buttonIndex == 3) {
        
        // 刷新
        if (Is_User_WKWeb) [self.wkWebView reload];
        else [self.webView reload];
        
    }
}

#pragma mark - wkWebView代理

// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"loading URL : %@",navigationAction.request.URL.absoluteString);
    if ([navigationAction.request.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if ([navigationAction.request.URL.absoluteString hasString:@"app_onCloseWindow"]) {
        [super back];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSURL * aURL = webView.URL;
    if (![aURL.absoluteString isEqualToString:self.homeUrl.absoluteString]) {
//        [self configBackItem];
    }else{
        if (self.navigationController.viewControllers.count <= 1) {
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.leftBarButtonItems = nil;
        }
    }
}


// 记得取消监听
- (void)dealloc {
    if (Is_User_WKWeb) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}

#pragma mark - webView代理

// 计算webView进度条
- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.loadCount ++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loadCount --;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.loadCount --;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    if ([webView.request.URL.absoluteString isEqualToString:self.homeUrl.absoluteString]) {
//        self.navigationItem.leftBarButtonItem = nil;
//    }else{
//        if (self.navigationItem.leftBarButtonItems.count == 0) {
//            [self crateBackButton];
//        }
//        if (self.navigationController.viewControllers.count <= 1) {
//            self.navigationItem.leftBarButtonItem = nil;
//        }
//    }

    if ([request.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }else if ([request.URL.absoluteString hasString:@"app_onCloseWindow"]) {
        [super back];
        return NO;
    }
    
    return YES;
}



@end
