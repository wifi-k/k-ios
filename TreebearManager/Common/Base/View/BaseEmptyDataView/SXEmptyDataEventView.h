//
//  SXEmptyDataEventView.h
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXEmptyDataEventView : UIView

+ (instancetype)tipsViewWithTopImageName:(NSString *)imageName content:(NSString *)content  btnText:(NSString *)btnText btnBlock:(void (^)(void))btnBlock;
    
@end
