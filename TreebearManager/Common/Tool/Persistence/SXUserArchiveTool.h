//
//  SXUserArchiveTool.h
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXUserArchiveTool : NSObject

    ///保存用户信息
+ (BOOL)saveUser;
    
    //获取用户信息
+ (SXUserModel *)user;
    
+ (BOOL)clearUserInfo;
    
@end

NS_ASSUME_NONNULL_END
