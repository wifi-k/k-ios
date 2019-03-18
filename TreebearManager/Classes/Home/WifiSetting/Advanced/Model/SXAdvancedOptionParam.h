//
//  SXAdvancedOptionParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXAdvancedOptionParam : SXBaseParam

///是否选中
@property (nonatomic, copy) NSNumber *selected;
///title1
@property (nonatomic, copy) NSString *title1;
///title2
@property (nonatomic, copy) NSString *title2;
///title3
@property (nonatomic, copy) NSString *title3;

@end

NS_ASSUME_NONNULL_END
