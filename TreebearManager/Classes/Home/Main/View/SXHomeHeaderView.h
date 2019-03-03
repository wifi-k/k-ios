//
//  SXHomeHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeHeaderView : UIView

+ (instancetype)headerView;

///点击绑定按钮回调
@property (nonatomic, copy) void (^clickBindingBtnBlock)(void);
///点击家庭码按钮回调
@property (nonatomic, copy) void (^clickFamilyCodeBtnBlock)(void);
///点击产品介绍按钮回调
@property (nonatomic, copy) void (^clickProductBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
