//
//  SXMobileUpdateHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXMobileUpdateHeaderView : UIView

+ (instancetype)headerView;

///点击完成按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(NSString *mobile);

@end

