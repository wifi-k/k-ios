//
//  SXUserModel.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUserModel.h"

@implementation SXUserModel

- (void)setValuesWithDict:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
}
    
    //从文件中解析对象时候调用
- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.user_id forKey:@"user_id"];
    [encoder encodeObject:self.user_type forKey:@"user_type"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.isLogin forKey:@"isLogin"];
}
    
    //将对象写入文件的时候调用
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init]){
        self.user_id = [decoder decodeObjectForKey:@"user_id"];
        self.user_type = [decoder decodeObjectForKey:@"user_type"];
        self.token = [decoder decodeObjectForKey:@"token"];
        self.isLogin = [decoder decodeObjectForKey:@"isLogin"];
    }
    return self;
}
    
@end
