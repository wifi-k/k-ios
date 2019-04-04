//
//  SXHomeMessageModel.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMessageModel : SXBaseModel

///类型
@property (nonatomic, copy) NSNumber *type;
///title
@property (nonatomic, copy) NSString *title;
///content
@property (nonatomic, copy) NSString *content;
///消息时间戳
@property (nonatomic, copy) NSString *createTime;

@end

NS_ASSUME_NONNULL_END
