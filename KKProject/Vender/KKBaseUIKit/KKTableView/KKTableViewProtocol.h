//
//  KKTableViewProtocol.h
//  ot-dayu
//
//  Created by 尤彬 on 2019/1/11.
//  Copyright © 2019 YangCK. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol KKViewModelProtocol;

@protocol KKTableViewProtocol <NSObject>

@optional

- (instancetype) initWithViewModel:(id<KKViewModelProtocol>)viewModel;


/**
 绑定ViewModel
 */
- (void) kk_bindViewModel;


/**
 创建视图
 */
- (void) kk_setupView;

/**
 设置控件的属性
 */
- (void) kk_setupConfig;

/**
 键盘失能
 */
- (void) kk_addReturnKeyBoard;


@end
