//
//  SXLANPortHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXLANPortHeaderView : UIView

+ (instancetype)headerView;

///点击保存按钮回调
@property (nonatomic, copy) void (^clickSaveBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
