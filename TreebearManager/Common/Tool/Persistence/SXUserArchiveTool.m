//
//  SXUserArchiveTool.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUserArchiveTool.h"

@implementation SXUserArchiveTool

static SXUserModel *_user;

static NSString *_filePath;
    
+ (void)initialize{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"user.archive"];
    //基本路径
    _filePath = filePath;
}
    
+ (BOOL)saveUser{
    return [NSKeyedArchiver archiveRootObject:_user toFile:_filePath];
}
    
+ (SXUserModel *)user{
    if (_user == nil) {
        //本地取出归档对象
        SXUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
        if (!user) {
            //1.初始化User对象
            SXUserModel *user = [[SXUserModel alloc] init];
            //1.1.先赋值
            _user = user;
            
            //2.保存用户到本地
            [self saveUser];
        }
        _user = user;
    }
    return _user;
}
    
+ (BOOL)clearUserInfo{
    SXUserModel *user = [self user];
    user.isLogin = @0;
    user.token = nil;
    return [self saveUser];
}
    
@end
