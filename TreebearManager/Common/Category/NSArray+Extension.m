//
//  NSArray+Extension.m
//  TreebearManager
//
//  Created by bear on 2019/3/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"

@implementation NSArray (Extension)

- (NSString *)toString{
    
    NSString *jsonStr = @"[";
    
//    for (NSInteger i = 0; i < self.count; ++i) {
//
//        if (i != 0) {
//
//            jsonStr = [jsonStr stringByAppendingString:@","];
//
//        }
//
//        jsonStr = [jsonStr stringByAppendingString:self[i]];
//
//    }
//
//    jsonStr = [jsonStr stringByAppendingString:@"]"];
    
    return jsonStr;
}

@end
