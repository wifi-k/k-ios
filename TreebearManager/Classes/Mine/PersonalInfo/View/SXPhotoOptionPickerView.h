//
//  SXPhotoOptionPickerView.h
//  TreebearManager
//
//  Created by bear on 2019/4/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXPhotoOptionPickerView : UIView

//设置遮罩蒙板响应事件是否关闭
@property (nonatomic, assign) BOOL closeUserInteractionEnabled;

@property (nonatomic,copy) void(^confirmBtnBlock)(NSInteger tag);

//初始化
+ (instancetype)pickerView;

//展示
- (void)showPickerView;

@end

NS_ASSUME_NONNULL_END
