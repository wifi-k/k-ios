//
//  SXWifiSettingHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXWifiSettingHeaderView : UIView

+ (instancetype)headerView;

///更改Wifi名称回调
@property (nonatomic, copy) void (^clickWifiNameBlock)(void);
///更改Wifi密码回调
@property (nonatomic, copy) void (^clickWifiPasswordBlock)(void);

@end

NS_ASSUME_NONNULL_END
