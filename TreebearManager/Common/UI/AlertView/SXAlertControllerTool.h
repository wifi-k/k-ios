//
//  SXAlertControllerTool.h
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXAlertControllerTool : NSObject

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirm:(void (^)(UIAlertAction *action))confirm cancel:(void (^)(UIAlertAction *action))cancel;

@end

NS_ASSUME_NONNULL_END
