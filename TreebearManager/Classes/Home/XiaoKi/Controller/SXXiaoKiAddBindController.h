//
//  SXXiaoKiAddBindController.h
//  TreebearManager
//
//  Created by bear on 2019/3/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXXiaoKiAddBindController : UIViewController

///选中添加绑定成功回调
@property (nonatomic, copy) void (^addBindSuccessBlock)(void);

@end
