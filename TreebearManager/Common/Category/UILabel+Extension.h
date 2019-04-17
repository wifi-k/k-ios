//
//  UILabel+Extension.h
//  TreebearManager
//
//  Created by bear on 2019/4/17.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
