//
//  SXTabBarController.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXTabBarController : UITabBarController

///连接成功
- (void)changeToMainHomeVC;
///连接失败
- (void)changeToHomeVC;
    
@end
