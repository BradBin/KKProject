//
//  KKNavigationBarHelper.m
//  KKViewControllerDemo
//
//  Created by 尤彬 on 2017/7/10.
//  Copyright © 2017年 youbin. All rights reserved.


#import "KKNavigationBarHelper.h"
#import "UIViewController+KKNavigationBar.h"

@implementation KKNavigationBarHelper

+ (instancetype)sharedInstance {
    
    static KKNavigationBarHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [KKNavigationBarHelper new];
    });
    return _instance;
}

// 设置默认的导航栏外观
- (void)kk_setupDefaultConfigure {
    
    self.kk_backgroundColor   = [UIColor whiteColor];
    self.kk_titleColor        = [UIColor blackColor];
    self.kk_titleFont         = [UIFont systemFontOfSize:17.0];
    
    self.kk_statusBarHidden   = false;
    self.kk_statusBarStyle    = UIStatusBarStyleDefault;
    self.kk_backStyle         = KKNavigationBarBackStyleBlack;
    
    self.kk_navItemLeftSpace  = 5.0f;
    self.kk_navItemRightSpace = 5.0f;
}

- (void)setKk_navItemLeftSpace:(CGFloat)kk_navItemLeftSpace {
    _kk_navItemLeftSpace = kk_navItemLeftSpace;
}

- (void)setKk_navItemRightSpace:(CGFloat)kk_navItemRightSpace {
    _kk_navItemRightSpace = kk_navItemRightSpace;
}

- (void)kk_setupCustomConfigure:(void (^)(KKNavigationBarHelper *helper))block {
    [self kk_setupDefaultConfigure];
    if (block) block(self);
}

// 更新配置
- (void)kk_updateConfigure:(void (^)(KKNavigationBarHelper *helper))block {
    if (block) block(self);
}

// 获取当前显示的控制器
- (UIViewController *)kk_visibleController {
    return [[UIApplication sharedApplication].keyWindow.rootViewController kk_visibleViewControllerIfExist];
}

@end
