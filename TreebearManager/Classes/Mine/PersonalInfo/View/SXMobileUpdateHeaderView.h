//
//  SXMobileUpdateHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXLoginParam.h"

@interface SXMobileUpdateHeaderView : UIView

+ (instancetype)headerView;

///参数
@property (nonatomic, strong) SXLoginParam *param;

///点击完成按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(SXLoginParam *param);

@end

