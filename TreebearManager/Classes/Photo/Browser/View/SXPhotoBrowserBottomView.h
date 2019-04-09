//
//  SXPhotoBrowserBottomView.h
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXPhotoBrowserBottomView : UIView

+ (instancetype)bottomView;

///点击操作按钮回调
@property (nonatomic, copy) void (^clickOptionBtnBlock)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
