//
//  SXTimeControlFooterView.h
//  TreebearManager
//
//  Created by bear on 2019/4/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXTimeControlFooterView : UIView

+ (instancetype)footerView;

///点击增加按钮回调
@property (nonatomic, copy) void (^clickAddTimeControlBlock)(void);

@end
