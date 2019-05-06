//
//  KKNavigationBarHelper.h
//  KKViewControllerDemo
//
//  Created by 尤彬 on 2017/7/10.
//  Copyright © 2017年 youbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKNavigationBarCommon.h"

@interface KKNavigationBarHelper : NSObject

/** 导航栏背景色 */
@property (nonatomic, strong) UIColor *kk_backgroundColor;
/** 导航栏标题颜色 */
@property (nonatomic, strong) UIColor *kk_titleColor;
/** 导航栏标题字体 */
@property (nonatomic, strong) UIFont *kk_titleFont;


/** 状态栏是否隐藏 */
@property (nonatomic, assign) BOOL kk_statusBarHidden;
/** 状态栏类型 */
@property (nonatomic, assign) UIStatusBarStyle kk_statusBarStyle;
/** 返回按钮类型(此方法只可全局配置，在控制器中修改无效) */
@property (nonatomic, assign) KKNavigationBarBackStyle kk_backStyle;


/** 导航栏左右按钮距屏幕左右的间距，默认是0，可自行调整 */
@property (nonatomic, assign) CGFloat   kk_navItemLeftSpace;
@property (nonatomic, assign) CGFloat   kk_navItemRightSpace;

/** 是否禁止调整间距，默认NO */
@property (nonatomic, assign) BOOL      kk_disableFixSpace;

+ (instancetype)sharedInstance;

// 统一配置导航栏外观，最好在AppDelegate中配置
- (void) kk_setupDefaultConfigure;
// 自定义
- (void)kk_setupCustomConfigure:(void (^)(KKNavigationBarHelper *helper))block;
// 更新配置
- (void)kk_updateConfigure:(void (^)(KKNavigationBarHelper *helper))block;
// 获取当前显示的控制器
- (UIViewController *)kk_visibleController;

@end
