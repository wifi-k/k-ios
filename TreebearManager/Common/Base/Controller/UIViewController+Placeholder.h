//
//  UIViewController+Placeholder.h
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXEmptyDataEventView.h"

@interface UIViewController (Placeholder)

- (void)showTipsViewWithTopImageName:(NSString *)imageName content:(NSString *)content  btnText:(NSString *)btnText btnBlock:(void (^)(void))btnBlock;
    
- (void)hideTipsView;
    
@end

