//
//  SXHomeMainSectionFooterView.h
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainSectionFooterView : UIView

+ (instancetype)footerView;

///点击更多按钮
@property (nonatomic,copy) void(^clickMoreBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
