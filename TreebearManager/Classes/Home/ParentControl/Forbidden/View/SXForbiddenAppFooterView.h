//
//  SXForbiddenAppFooterView.h
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenAppFooterView : UIView

+ (instancetype)footerView;

///点击增加按钮回调
@property (nonatomic, copy) void (^clickAddForbiddenBlock)(void);

@end

NS_ASSUME_NONNULL_END
