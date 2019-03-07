//
//  SXAdvancedOptionModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

@interface SXAdvancedOptionModel : SXBaseModel

///是否选中
@property (nonatomic, copy) NSNumber *selected;
///行数
@property (nonatomic, copy) NSNumber *row;
///title
@property (nonatomic, copy) NSString *title;

@end
