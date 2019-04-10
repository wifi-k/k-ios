//
//  SXAsset.h
//  TreebearManager
//
//  Created by bear on 2019/4/10.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXAsset : NSObject

///相册单元
@property (nonatomic, strong) PHAsset *asset;
///是否选中
@property (nonatomic, assign) BOOL isChecked;

@end

NS_ASSUME_NONNULL_END
