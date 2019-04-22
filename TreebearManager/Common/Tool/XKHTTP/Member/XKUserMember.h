//
//  XKUserMember.h
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKUserMember : NSObject

SingletonInterface(XKUserMember)

///用户token
@property (nonatomic, copy) NSString *token;
///是否管理员角色
@property (nonatomic, assign) BOOL isManager;

@end
