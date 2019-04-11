//
//  SXPhotoTopView.h
//  TreebearManager
//
//  Created by bear on 2019/4/11.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXPhotoTopView : UIView

+ (instancetype)topView;

///选中张数
@property (nonatomic, assign) NSInteger count;

///点击关闭按钮
@property (nonatomic, copy) void (^clickCloseBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
