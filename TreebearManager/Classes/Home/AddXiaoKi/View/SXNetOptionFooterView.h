//
//  SXNetOptionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXNetOptionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXNetOptionFooterView : UIView

+ (instancetype)footerView;

///模型数组
@property (nonatomic, strong) NSArray *dataArray;

///点击下一步按钮回调
@property (nonatomic, copy) void (^clickNextBtnBlock)(SXNetOptionModel *model);

@end

NS_ASSUME_NONNULL_END
