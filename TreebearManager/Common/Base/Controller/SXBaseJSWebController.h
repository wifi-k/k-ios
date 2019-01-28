//
//  SXBaseJSWebController.h
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXBaseJSWebController : UIViewController<UIWebViewDelegate,WKNavigationDelegate,SKStoreProductViewControllerDelegate,UIViewControllerPreviewingDelegate,WKUIDelegate>

@property (nonatomic, weak) WKWebView *wkWebView;

@property (nonatomic, copy) NSURL *url;

- (instancetype)initWithURL:(NSURL*)url;

@property (nonatomic, copy) NSString *nativeTitle;

@end

NS_ASSUME_NONNULL_END
