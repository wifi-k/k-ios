//
//  SXDropDownMenu.h
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SXDropDownMenu;

@protocol SXDropDownMenuDelegate <NSObject>
@required
- (void)popDropMenu:(SXDropDownMenu *)popView row:(NSInteger)row;
@end

@interface SXDropDownMenu : UIView

@property (nonatomic, weak) id<SXDropDownMenuDelegate> delegate;

+ (instancetype)dropMenu;

///隐藏选择菜单
- (void)hideDropDownMenuWithBtnFrame:(CGRect)btnFrame;

///显示选择菜单
- (void)showDropDownMenuWithButtonFrame:(CGRect)buttonFrame arrayOfTitle:(NSArray *)titleArr;

@end
