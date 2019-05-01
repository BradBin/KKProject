//
//  UIViewController+KKNavigationBar.h
//  KKCustomNavigationBar
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//  使用运行时为UIViewController添加分类

#import <UIKit/UIKit.h>
#import "KKNavigationBarHelper.h"

UIKIT_EXTERN NSString *const KKViewControllerPropertyChangedNotification;

// 交给单独控制器处理
@protocol KKViewControllerPushDelegate <NSObject>

@optional
- (void)kk_pushToNextViewController;

@end

@interface UIViewController (KKNavigationBar)

/** 是否禁止当前控制器的滑动返回(包括全屏返回和边缘返回) */
@property (nonatomic, assign) BOOL kk_interactivePopDisabled;

/** 是否禁止当前控制器的全屏滑动返回 */
@property (nonatomic, assign) BOOL kk_fullScreenPopDisabled;

/** 全屏滑动时，滑动区域距离屏幕左边的最大位置，默认是0：表示全屏都可滑动 */
@property (nonatomic, assign) CGFloat kk_popMaxAllowedDistanceToLeftEdge;

/** 设置导航栏的透明度 */
@property (nonatomic, assign) CGFloat kk_navBarAlpha;

/** 设置状态栏类型 */
@property (nonatomic, assign) UIStatusBarStyle kk_statusBarStyle;

/** 设置状态栏是否显示(default is NO 即不隐藏) */
@property (nonatomic, assign) BOOL kk_statusBarHidden;

/** 设置返回按钮的类型 */
@property (nonatomic, assign) KKNavigationBarBackStyle kk_backStyle;

/** push代理 */
@property (nonatomic, weak) id<KKViewControllerPushDelegate> kk_pushDelegate;

/**
 返回显示的控制器
 */
- (UIViewController *)kk_visibleViewControllerIfExist;

/**
 返回按钮点击
 */
- (void)kk_backItemClickAction:(id)sender;

@end
