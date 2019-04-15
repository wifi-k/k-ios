//
//  SXNetOptionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/4/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXNetOptionHeaderView : UIView

+ (instancetype)headerView;

///更改title
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
