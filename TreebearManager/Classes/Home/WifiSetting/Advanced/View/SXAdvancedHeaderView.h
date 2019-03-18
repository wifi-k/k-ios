//
//  SXAdvancedHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXAdvancedOptionParam.h"

@interface SXAdvancedHeaderView : UIView

+ (instancetype)headerView;

///点击保存按钮回调
//@property (nonatomic, copy) void (^clickSaveBtnBlock)(void);
///点击背景视图
@property (nonatomic, copy) void (^clickBgBlock)(NSInteger tag);

@property (nonatomic, strong) SXAdvancedOptionParam *param;

@end

