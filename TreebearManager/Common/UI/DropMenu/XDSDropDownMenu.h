//
//  XDSDropDownMenu.h
//  shts_ios_xds
//
//  Created by cdj on 2018/5/8.
//  Copyright © 2018年 itiis. All rights reserved.
//

#pragma mark - 选择菜单封装类

#import <UIKit/UIKit.h>
@class XDSDropDownMenu;

@protocol XDSDropDownMenuDelegate
@required
- (void)setDropDownDelegate:(XDSDropDownMenu *)sender;//设置下拉菜单的tag值
@end

@interface XDSDropDownMenu : UIView

///代理
@property (nonatomic, weak) id <XDSDropDownMenuDelegate> delegate;

///隐藏选择菜单
- (void)hideDropDownMenuWithBtnFrame:(CGRect)btnFrame;

///显示选择菜单
- (void)showDropDownMenuWithButtonFrame:(CGRect)buttonFrame arrayOfTitle:(NSArray *)titleArr;

@end
