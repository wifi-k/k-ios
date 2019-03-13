//
//  SXOnlineOptionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXOnlineOptionButton.h"

@interface SXOnlineOptionHeaderView : UIView

+ (instancetype)headerView;

///点击菜单按钮回调
@property (nonatomic, copy) void (^clickOptionBtnBlock)(BOOL isSelected);

///菜单按钮
@property (weak, nonatomic) IBOutlet SXOnlineOptionButton *optionBtn;

///菜单名称
@property (nonatomic, copy) NSString *optionStr;

@end
