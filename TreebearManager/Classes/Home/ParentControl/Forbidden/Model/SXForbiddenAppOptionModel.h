//
//  SXForbiddenAppOptionModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenAppOptionModel : SXBaseModel

///禁用App
@property (nonatomic, copy) NSString *title;
///行
@property (nonatomic, copy) NSNumber *row;

@end

NS_ASSUME_NONNULL_END
