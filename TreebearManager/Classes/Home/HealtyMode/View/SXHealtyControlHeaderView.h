//
//  SXHealtyControlHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHealtyControlHeaderView : UIView

+ (instancetype)headerView;

- (NSNumber *)isSwitchOn;

@property (nonatomic, copy) NSNumber *op;

///点击健康模式开关回调
@property (nonatomic, copy) void (^clickSwitchBtnBlock)(BOOL isOn);

@end

NS_ASSUME_NONNULL_END
