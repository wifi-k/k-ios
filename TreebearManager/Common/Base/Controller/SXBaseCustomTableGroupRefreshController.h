//
//  SXBaseCustomTableGroupRefreshController.h
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseCustomTableViewGroupController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXBaseCustomTableGroupRefreshController : SXBaseCustomTableViewGroupController

- (void)refresh;//自动下拉刷新
- (void)dropRefresh;//下拉
- (void)pullRefresh;//上拉
- (void)endHeaderRefresh;//结束下拉刷新
- (void)endFooterRefresh;//结束上拉刷新
- (void)showNoMoreDataFooterView;//已经到底
    
@end

NS_ASSUME_NONNULL_END
