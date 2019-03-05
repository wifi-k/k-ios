//
//  SXForbiddenAppModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenAppModel : NSObject

///禁用方案
@property (nonatomic, copy) NSString *title;
///行
@property (nonatomic, copy) NSNumber *row;

@end

NS_ASSUME_NONNULL_END