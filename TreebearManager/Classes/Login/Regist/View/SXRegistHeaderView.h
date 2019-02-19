//
//  SXRegistHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXRegistParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXRegistHeaderView : UIView

+ (instancetype)headerView;

@property (nonatomic, strong) SXRegistParam *param;

@end

NS_ASSUME_NONNULL_END
