//
//  SXHomeMainSectionFooterView2.h
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *SXHomeMainSectionFooterView2ID = @"SXHomeMainSectionFooterView2ID";

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainSectionFooterView2 : UIView

+ (instancetype)footerView;

///点击周报按钮回调
@property (nonatomic,copy) void(^clickReportBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
