//
//  KKViewController.h
//  KKViewController
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//  所有需要显示导航条的基类，可根据自己的需求设置导航栏
//  基本原理就是为每一个控制器添加自定义导航条，做到导航条与控制器相连的效果

#import <UIKit/UIKit.h>
#import "KKNavigationBar.h"
#import "KKNavigationBarHelper.h"
#import "KKNavigationBarCategory.h"
#import "KKViewControllerProtocol.h"

@interface KKViewController : UIViewController<KKViewControllerProtocol>

/** 自定义导航条 */
@property (nonatomic, strong, readonly) KKNavigationBar     *kk_navigationBar;
/** 自定义导航栏栏目 */
@property (nonatomic, strong, readonly) UINavigationItem    *kk_navigationItem;
/** 快速设置导航栏属性 */
@property (nonatomic, strong) UIColor                       *kk_navBarTintColor;


/** 设置导航栏背景，[UIColor clearColor]可设置为透明 */
@property (nonatomic, strong) UIColor                       *kk_navBackgroundColor;
@property (nonatomic, strong) UIImage                       *kk_navBackgroundImage;

/** 设置导航栏分割线颜色或图片 */
@property (nonatomic, strong) UIColor                       *kk_navShadowColor;
@property (nonatomic, strong) UIImage                       *kk_navShadowImage;

@property (nonatomic, strong) UIColor                       *kk_navTintColor;
@property (nonatomic, strong) UIView                        *kk_navTitleView;
@property (nonatomic, strong) UIColor                       *kk_navTitleColor;

@property (nonatomic, strong) UIFont                        *kk_navTitleFont;
@property (nonatomic, strong) UIBarButtonItem               *kk_navLeftBarButtonItem;
@property (nonatomic, strong) NSArray<UIBarButtonItem *>    *kk_navLeftBarButtonItems;

@property (nonatomic, strong) UIBarButtonItem               *kk_navRightBarButtonItem;
@property (nonatomic, strong) NSArray<UIBarButtonItem *>    *kk_navRightBarButtonItems;

/** 导航栏左右按钮距离屏幕边缘的距离 */
@property (nonatomic, assign) CGFloat                       kk_navItemLeftSpace;
@property (nonatomic, assign) CGFloat                       kk_navItemRightSpace;

/** 页面标题-快速设置 */
@property (nonatomic, copy) NSString                        *kk_navTitle;

/** 是否隐藏分割线（默认NO）注意：此方法尽量在viewDidAppear中使用，如果想在viewDidLoad中隐藏分割线，可使用以下方法
 *  1、self.kk_navShadowColor = [UIColor clearColor]
 *  2、self.kk_navShadowImage = [UIImage new];
 */
@property (nonatomic, assign) BOOL                          kk_navLineHidden;


/**
 显示导航栏分割线
 */
- (void)kk_showNavLine;
/**
 隐藏导航栏分割线
 */
- (void)kk_hideNavLine;


//显示loading状态
- (void)kk_showLoading;
//显示加载失败状态
- (void)kk_showFailed;
- (void)kk_closePlaceHolder;
//重写老刷新加载失败
- (void)kk_refreshWhenFailed;

@end
