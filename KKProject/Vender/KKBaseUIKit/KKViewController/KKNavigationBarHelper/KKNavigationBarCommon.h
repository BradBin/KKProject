//
//  KKCommon.h
//  KKViewControllerTest
//
//  Created by 尤彬 on 2017/10/13.
//  Copyright © 2017年 youbin. All rights reserved.
//  一些公共的方法、宏定义、枚举等

#ifndef KKNavigationBarCommon_h
#define KKNavigationBarCommon_h

#import <objc/runtime.h>


/**********************屏幕相关配置***************************/
/**
 屏幕的宽度
 
 @return 屏幕宽度
 */
static inline CGFloat _kk_ScreenWidth(){
    static CGFloat _screenWidth = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _screenWidth = UIScreen.mainScreen.bounds.size.width;
    });
    return _screenWidth;
}

/**
 屏幕的高度
 
 @return 屏幕高度
 */
static inline CGFloat _kk_ScreenHeight(){
    static CGFloat _screenHeight = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _screenHeight = UIScreen.mainScreen.bounds.size.height;
    });
    return _screenHeight;
}

/**
 判断当前设备是否是iPhone X刘海屏系列
 
 @return true:是 否则反之
 */
static inline BOOL _kk_isIphoneXSeries(){
    BOOL isIhoneXSeries = false;
    if (@available(iOS 11 , *)) {
        UIEdgeInsets safeAreaInsets = UIApplication.sharedApplication.keyWindow.safeAreaInsets;
        if (safeAreaInsets.bottom == UIEdgeInsetsZero.bottom) {
            isIhoneXSeries = false;
        }else{
            isIhoneXSeries = true;
        }
    }
    return isIhoneXSeries;
}

/**
 状态栏的高度
 
 @return 高度
 */
static inline CGFloat _kk_status_height(){
    return _kk_isIphoneXSeries() ? 44.0f : 20.0f;
}

/**
 顶部安全区域
 
 @return 高度
 */
static inline CGFloat _kk_safe_top(){
    return _kk_isIphoneXSeries() ? 24.0f : 0.0f;
}

/**
 底部安全区域
 
 @return 高度
 */
static inline CGFloat _kk_safe_bottom(){
    return _kk_isIphoneXSeries() ? 34.0f : 0.0f;
}

/**
 导航内容的高度
 
 @return 高度
 */
static inline CGFloat _kk_navBar_height(){
    return 44.0f;
}

/**
 导航栏的高度
 
 @return 高度
 */
static inline CGFloat _kk_nav_height(){
    return  _kk_navBar_height() + _kk_status_height();
}

/**
 tabBar的高度
 
 @return 高度
 */
static inline CGFloat _kk_tabBar_height(){
    return _kk_isIphoneXSeries() ? 83.0f : 49.0f;
}




typedef NS_ENUM(NSUInteger, KKNavigationBarBackStyle) {
    KKNavigationBarBackStyleNone,    // 无返回按钮，可自行设置
    KKNavigationBarBackStyleBlack,   // 黑色返回按钮
    KKNavigationBarBackStyleWhite    // 白色返回按钮
};

// 使用static inline创建静态内联函数，方便调用
static inline void _kk_swizzled_method(Class cls ,SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    BOOL isAdd = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAdd) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#endif /* KKNavigationBarCommon_h */
