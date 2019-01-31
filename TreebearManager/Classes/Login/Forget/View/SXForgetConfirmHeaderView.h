//
//  SXForgetConfirmHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXForgetConfirmHeaderView : UIView

+ (instancetype)headerView;

///点击确认按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(void);
///点击同意按钮回调
@property (nonatomic, copy) void (^clickAgreeBtnBlock)(void);
///点击协议按钮回调
@property (nonatomic, copy) void (^clickLicenceBtnBlock)(void);
    
@end

NS_ASSUME_NONNULL_END
