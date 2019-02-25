//
//  SXHomeMainHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainHeaderView : UIView
    
+ (instancetype)headerView;

@property (nonatomic, copy) void (^clickMessageBgViewBlock)(void);
@property (nonatomic, copy) void (^clickSettingBtnBlock)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
