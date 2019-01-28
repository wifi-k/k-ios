//
//  SXBaseJSWebController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseJSWebController.h"

@interface SXBaseJSWebController ()
@property (nonatomic, weak) UIProgressView *progressView;
@end

@implementation SXBaseJSWebController

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
    
    //1.设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2.进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
    progressView.tintColor = SXColorBlue;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    //先实例化配置类,以前的属性有的放到了这里
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    //设置偏好设置,注册供js调用的方法
    WKPreferences *preferences = [WKPreferences new];
    // 默认认为YES
    preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //preferences.minimumFontSize = 16.0;
    configuration.preferences = preferences;
    
    //3.初始化web
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    wkWebView.backgroundColor = UIColor.whiteColor;
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    [wkWebView setMultipleTouchEnabled:YES];
    [wkWebView.scrollView setAlwaysBounceVertical:YES];
    [wkWebView setAllowsBackForwardNavigationGestures:true];
    [self.view insertSubview:wkWebView belowSubview:progressView];
    
    //4.添加进度条监听
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [wkWebView loadRequest:request];
    self.wkWebView = wkWebView;
    
    if (@available(iOS 9.0, *)) {
        if (UIDevice.currentDevice.systemVersion.floatValue >= 9.0f  && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
            [self registerForPreviewingWithDelegate:self sourceView:self.view];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.wkWebView.frame = self.view.bounds;
}

- (void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark -WKNavigationDelegate代理-
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

//9.需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    DLog(@"证书验证");
    NSURLCredential *newCred = [NSURLCredential credentialWithUser:@"" password:@"" persistence:NSURLCredentialPersistenceNone];
    //为challenge 的发送方提供 credential    [[challenge sender] useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

//10.系统>=9.0才能使用，web内容处理中断时会触发
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
//}

#pragma mark -WKUIDelegate代理-
/**
 web界面中有弹出警告框时调用
 @param webView 实现该代理的webview
 @param message 警告框中的内容
 @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    DLog(@"-------web界面中有弹出警告框时调用");
}

//创建新的webView时调用的方法
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    DLog(@"-----创建新的webView时调用的方法");
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (!frameInfo.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

//关闭webView时调用的方法
- (void)webViewDidClose:(WKWebView *)webView{
    DLog(@"----关闭webView时调用的方法");
}

//**下面这些方法是交互JavaScript的方法**
//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    DLog(@"%@",message);
    completionHandler(YES);
}

//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    DLog(@"%@",prompt);
    completionHandler(@"123");
}

//默认预览元素调用
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo{
    DLog(@"-----默认预览元素调用");
    return YES;
}

//返回一个视图控制器将导致视图控制器被显示为一个预览。返回nil将WebKit的默认预览的行为。
- (UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id<WKPreviewActionItem>> *)previewActions{
    DLog(@"----返回一个视图控制器将导致视图控制器被显示为一个预览。返回nil将WebKit的默认预览的行为。");
    return self;
}

//允许应用程序向它创建的视图控制器弹出
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController{
    DLog(@"----允许应用程序向它创建的视图控制器弹出");
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

@end
