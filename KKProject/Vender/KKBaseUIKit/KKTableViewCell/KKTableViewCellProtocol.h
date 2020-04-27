//
//  KKTableViewCellProtocol.h
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/10/25.
//  Copyright © 2018 youbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKViewModelProtocol.h"
@protocol KKTableViewCellProtocol <NSObject>

@optional

- (instancetype) kk_initWithViewModel:(id<KKViewModelProtocol >)viewModel;

/**
 添加和布局控件
 */
- (void) kk_setupView;

/**
 绑定
 */
- (void) kk_bindViewModel;

@end
