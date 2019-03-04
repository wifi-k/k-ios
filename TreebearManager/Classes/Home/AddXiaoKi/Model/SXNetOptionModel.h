//
//  SXNetOptionModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXNetOptionModel : NSObject

///是否选中
@property (nonatomic, copy) NSNumber *selected;
///行数
@property (nonatomic, copy) NSNumber *row;
///title
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
