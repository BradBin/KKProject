//
//  KKViewControllerProtocol.h
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/10/25.
//  Copyright © 2018 youbin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol KKViewModelProtocol;

@protocol KKViewControllerProtocol <NSObject>

@optional


/**
 绑定

 @param viewModel viewModel
 @return 实例对象
 */
- (instancetype) initWithViewModel:(id<KKViewModelProtocol>)viewModel;

/**
 绑定viewModel
 */
- (void)kk_bindViewModel;

/**
 创建和布局视图
 */
- (void)kk_addSubviews;

/**
 配置属性: 界面已经出现后使用
 */
- (void)kk_setupConfigurate;

/**
 重新布局导航栏
 */
- (void)kk_layoutNavigation;

/**
 执行绑定的ViewModel
 */
- (void)kk_executeViewModel;

/**
 需要刷新数据
 */
- (void)kk_needRefreshData;


/**
 
 */
- (void)recoverKeyboard;

/**
 重新登录
 */
- (void)kk_needRelogin;



@end
