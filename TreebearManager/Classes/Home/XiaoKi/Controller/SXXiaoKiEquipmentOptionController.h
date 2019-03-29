//
//  SXXiaoKiEquipmentOptionController.h
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseCustomTablePlainRrfreshController.h"
#import "SXHomeXiaoKiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXXiaoKiEquipmentOptionController : SXBaseCustomTablePlainRrfreshController

///选中模型回调
@property (nonatomic, copy) void (^selectOptionModelBlock)(void);

@end

NS_ASSUME_NONNULL_END
