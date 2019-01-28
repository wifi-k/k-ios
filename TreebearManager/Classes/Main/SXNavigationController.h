//
//  SXNavigationController.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SXNavigationController;

@protocol BackButtonHandlerProtocol <NSObject>

@optional
- (void)willPopOnBackWithNavigationCtrl:(SXNavigationController *)navigationCtrl;
- (BOOL)shouldPopGestureRecognizerWithNavigationCtrl:(SXNavigationController *)navigationCtrl;

@end

@interface UIViewController (BackButtonHandler)<BackButtonHandlerProtocol>

@end

@interface SXNavigationController : UINavigationController

@end
