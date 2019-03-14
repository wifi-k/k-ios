//
//  SXAlertControllerTool.h
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXAlertControllerTool : NSObject

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirm:(void (^)(UIAlertAction *action))confirm cancel:(void (^)(UIAlertAction *action))cancel;

+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message confirm:(void (^)(UIAlertAction *action))confirm cancel:(void (^)(UIAlertAction *action))cancel;

@end
