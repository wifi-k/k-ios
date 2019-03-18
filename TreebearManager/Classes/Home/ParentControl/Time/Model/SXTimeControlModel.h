//
//  SXTimeControlModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXTimeControlModel : SXBaseModel

///禁用方案
@property (nonatomic, copy) NSString *title;
///描述
@property (nonatomic, copy) NSString *content;
///描述1
@property (nonatomic, copy) NSString *content1;
///描述2
@property (nonatomic, copy) NSString *content2;
///行
@property (nonatomic, copy) NSNumber *row;

@end

NS_ASSUME_NONNULL_END
