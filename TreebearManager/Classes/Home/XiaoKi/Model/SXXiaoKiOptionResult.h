//
//  SXXiaoKiOptionResult.h
//  TreebearManager
//
//  Created by bear on 2019/3/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"
#import "SXHomeXiaoKiModel.h"

@interface SXXiaoKiOptionResult : SXBaseModel

SingletonInterface(SXXiaoKiOptionResult)

/**
 * 个人信息
 */
@property (nonatomic, strong) SXHomeXiaoKiModel *selectedModel;

@end

