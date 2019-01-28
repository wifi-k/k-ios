//
//  SXBaseWebController.h
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXBaseWebController : UIViewController

- (instancetype)initWithURL:(NSURL*)url;

@property (nonatomic, strong) NSString *nativeTitle;

@end

NS_ASSUME_NONNULL_END
