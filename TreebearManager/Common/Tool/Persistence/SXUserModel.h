//
//  SXUserModel.h
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXUserModel : NSObject
    
///用户ID
@property (nonatomic, copy) NSString *user_id;
///用户类型
@property (nonatomic, copy) NSString *user_type;
///用户token
@property (nonatomic, copy) NSString *token;
///是否登录
@property (nonatomic, copy) NSNumber *isLogin;

//+ (instancetype)modelWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValuesWithDict:(NSDictionary *)dict;

@end

