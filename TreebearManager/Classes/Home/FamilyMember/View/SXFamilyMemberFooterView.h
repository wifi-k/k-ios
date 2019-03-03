//
//  SXFamilyMemberFooterView.h
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXFamilyMemberFooterView : UIView

+ (instancetype)footerView;

///点击增加按钮回调
@property (nonatomic, copy) void (^clickAddMemberBlock)(void);

@end

NS_ASSUME_NONNULL_END
