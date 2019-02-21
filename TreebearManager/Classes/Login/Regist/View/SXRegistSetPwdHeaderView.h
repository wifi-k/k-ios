//
//  SXRegistSetPwdHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXRegistParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXRegistSetPwdHeaderView : UIView

+ (instancetype)headerView;

///点击确认按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(void);
///点击同意按钮回调
@property (nonatomic, copy) void (^clickAgreeBtnBlock)(void);
///点击协议按钮回调
@property (nonatomic, copy) void (^clickLicenceBtnBlock)(void);

///注册参数
@property (nonatomic, strong) SXRegistParam *param;

@end

NS_ASSUME_NONNULL_END
