//
//  SXNickNameUpdateHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXMineUserInfoParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXNickNameUpdateHeaderView : UIView

+ (instancetype)headerView;

- (void)setUpData;

@property (nonatomic, strong) SXMineUserInfoParam *param;

@end

NS_ASSUME_NONNULL_END
