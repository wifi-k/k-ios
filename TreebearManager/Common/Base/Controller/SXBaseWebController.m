//
//  SXBaseWebController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseWebController.h"
#import <WebKit/WebKit.h>
#import <StoreKit/StoreKit.h>

@interface SXBaseWebController ()<UIWebViewDelegate,UIActionSheetDelegate,WKNavigationDelegate,SKStoreProductViewControllerDelegate,UIViewControllerPreviewingDelegate>
@property (nonatomic, weak) WKWebView *wkWebView;
@property (nonatomic, weak) UIProgressView *progressView;
@property (nonatomic, copy) NSURL *url;
@end

@implementation SXBaseWebController

#pragma mark -生命周期方法-
- (instancetype)initWithURL:(NSURL*)url{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (void)setNativeTitle:(NSString *)nativeTitle{
    _nativeTitle = nativeTitle;
    self.navigationItem.title = nativeTitle;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.wkWebView.frame = self.view.bounds;
}

- (void)configUI {
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
    progressView.tintColor = SXColorBlue;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    //初始化web
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    wkWebView.backgroundColor = UIColor.whiteColor;
    wkWebView.navigationDelegate = self;
    [wkWebView setMultipleTouchEnabled:YES];
    [wkWebView.scrollView setAlwaysBounceVertical:YES];
    [wkWebView setAllowsBackForwardNavigationGestures:true];
    [self.view insertSubview:wkWebView belowSubview:progressView];
    
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [wkWebView loadRequest:request];
    self.wkWebView = wkWebView;
    
    if (UIDevice.currentDevice.systemVersion.floatValue >= 9.0f  && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
}

#pragma mark -wkWebView代理-
///1.在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

///2.在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    DLog(@"收到响应后");
}

///3.页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    self.navigationItem.title = @"正在加载...";
}

///4.主机地址被重定向时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    DLog(@"接收到服务器跳转请求");
}

///5.页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    self.navigationItem.title = @"加载失败...";
}

///6.当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    DLog(@"内容开始返回");
}

///7.页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (!self.nativeTitle) {
        self.navigationItem.title = webView.title;
    }
}

//8.跳转失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    DLog(@"页面跳转失败");
}

//9.如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    DLog(@"证书验证");
    NSURLCredential *newCred = [NSURLCredential credentialWithUser:@"" password:@"" persistence:NSURLCredentialPersistenceNone];
    //为challenge 的发送方提供 credential    [[challenge sender] useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

///更新加载进度条进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:newprogress animated:YES];
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString*)findNumFromStr:(NSString*)originalString{
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    return numberString;
}

#pragma mark -web页面基本操作按钮-
- (void)backToLastWeb{
    if (self.wkWebView.backForwardList.backList.count>0) {
        [self.wkWebView goToBackForwardListItem:self.wkWebView.backForwardList.backItem];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)closeWebView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadWebView{
    if (self.wkWebView.backForwardList.backList.count > 0) {
        [self.wkWebView reload];
    }else{
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        [self.wkWebView loadRequest:request];
    }
}

@end
