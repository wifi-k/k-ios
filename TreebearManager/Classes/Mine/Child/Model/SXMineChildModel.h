//
//  SXMineChildModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXMineChildModel : SXBaseModel

///禁用方案
@property (nonatomic, copy) NSString *title;
///行
@property (nonatomic, copy) NSNumber *row;

@end

NS_ASSUME_NONNULL_END
