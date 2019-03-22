//
//  SXMineAboutUsController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineAboutUsController.h"

@interface SXMineAboutUsController ()

@property (nonatomic, weak) UIWebView *webView;
@end

@implementation SXMineAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.navigationItem.title = @"关于我们";
    
    self.view.backgroundColor = SXColorWhite;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.webView = webView;
    
    NSString *urlStr = @"https://www.treebear.cn";
    NSURL *locationURL = [NSURL URLWithString:urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:locationURL];
    [webView loadRequest:request];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.view.bounds;
}

@end
