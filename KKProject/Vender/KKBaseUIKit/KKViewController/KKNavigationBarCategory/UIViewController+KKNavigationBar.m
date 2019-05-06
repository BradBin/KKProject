//
//  UIViewController+KKNavigationBar.m
//  KKCustomNavigationBar
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//

#import "UIViewController+KKNavigationBar.h"
#import "AppDelegate.h"
#import "KKViewController.h"
#import <objc/runtime.h>

NSString *const KKViewControllerPropertyChangedNotification = @"KK.ViewController.Property.Changed.Notification";

static const void* KKInteractivePopKey  = @"KKInteractivePopKey";
static const void* kKFullScreenPopKey   = @"KKFullScreenPopKey";
static const void* KKPopMaxDistanceKey  = @"KKPopMaxDistanceKey";
static const void* KKNavBarAlphaKey     = @"KKNavBarAlphaKey";
static const void* KKStatusBarStyleKey  = @"KKStatusBarStyleKey";
static const void* KKStatusBarHiddenKey = @"KKStatusBarHiddenKey";
static const void* KKBackStyleKey       = @"KKBackStyleKey";
static const void* KKPushDelegateKey    = @"KKPushDelegateKey";

@implementation UIViewController (KKNavigationBar)

// 方法交换
+ (void)load {
    // 保证其只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        _kk_swizzled_method(class, @selector(viewDidAppear:) ,@selector(kk_viewDidAppear:));
    });
}

- (void)kk_viewDidAppear:(BOOL)animated {
    
    // 在每次视图出现的时候重新设置当前控制器的手势
    [[NSNotificationCenter defaultCenter] postNotificationName:KKViewControllerPropertyChangedNotification object:@{@"viewController": self}];
    
    [self kk_viewDidAppear:animated];
}

#pragma mark - StatusBar
- (BOOL)prefersStatusBarHidden {
    return self.kk_statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.kk_statusBarStyle;
}

#pragma mark - Added Property
- (BOOL)kk_interactivePopDisabled {
    return [objc_getAssociatedObject(self, KKInteractivePopKey) boolValue];
}

- (void)setKk_interactivePopDisabled:(BOOL)kk_interactivePopDisabled {
    objc_setAssociatedObject(self, KKInteractivePopKey, @(kk_interactivePopDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 当属性改变时，发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KKViewControllerPropertyChangedNotification object:@{@"viewController": self}];
}

- (BOOL)kk_fullScreenPopDisabled {
    return [objc_getAssociatedObject(self, kKFullScreenPopKey) boolValue];
}

- (void)setKk_fullScreenPopDisabled:(BOOL)kk_fullScreenPopDisabled {
    objc_setAssociatedObject(self, kKFullScreenPopKey, @(kk_fullScreenPopDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 当属性改变时，发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KKViewControllerPropertyChangedNotification object:@{@"viewController": self}];
}

- (CGFloat)kk_popMaxAllowedDistanceToLeftEdge {
    return [objc_getAssociatedObject(self, KKPopMaxDistanceKey) floatValue];
}

- (void)setKk_popMaxAllowedDistanceToLeftEdge:(CGFloat)kk_popMaxAllowedDistanceToLeftEdge {
    objc_setAssociatedObject(self, KKPopMaxDistanceKey, @(kk_popMaxAllowedDistanceToLeftEdge), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 当属性改变时，发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KKViewControllerPropertyChangedNotification object:@{@"viewController": self}];
}

- (CGFloat)kk_navBarAlpha {
    return [objc_getAssociatedObject(self, KKNavBarAlphaKey) floatValue];
}

- (void)setKk_navBarAlpha:(CGFloat)kk_navBarAlpha {
    objc_setAssociatedObject(self, KKNavBarAlphaKey, @(kk_navBarAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setNavBarAlpha:kk_navBarAlpha];
}

- (UIStatusBarStyle)kk_statusBarStyle {
    id style = objc_getAssociatedObject(self, KKStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}

- (void)setKk_statusBarStyle:(UIStatusBarStyle)kk_statusBarStyle {
    objc_setAssociatedObject(self, KKStatusBarStyleKey, @(kk_statusBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // 调用隐藏方法
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (BOOL)kk_statusBarHidden {
    return [objc_getAssociatedObject(self, KKStatusBarHiddenKey) boolValue];
}

- (void)setKk_statusBarHidden:(BOOL)kk_statusBarHidden {
    objc_setAssociatedObject(self, KKStatusBarHiddenKey, @(kk_statusBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // 调用隐藏方法
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (KKNavigationBarBackStyle)kk_backStyle {
    id style = objc_getAssociatedObject(self, KKBackStyleKey);
    
    return (style != nil) ? [style integerValue] : KKNavigationBarBackStyleBlack;
}

- (void)setKk_backStyle:(KKNavigationBarBackStyle)kk_backStyle {
    objc_setAssociatedObject(self, KKBackStyleKey, @(kk_backStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController.childViewControllers.count <= 1) return;
    if (self.kk_backStyle != KKNavigationBarBackStyleNone) {
        UIImage *backImage = self.kk_backStyle == KKNavigationBarBackStyleBlack ? [UIImage imageNamed:@"KKNavigationBar.bundle/btn_back_black.png"] : [UIImage imageNamed:@"KKNavigationBar.bundle/btn_back_white.png"];
        if ([self isKindOfClass:[KKViewController class]]) {
            KKViewController *vc = (KKViewController *)self;
            vc.kk_navLeftBarButtonItem =  [UIBarButtonItem kk_itemWithTitle:nil titleColor:nil imageName:backImage highImageName:backImage target:self action:@selector(kk_backItemClickAction:)];
        }
    }
}




- (id<KKViewControllerPushDelegate>)kk_pushDelegate {
    return objc_getAssociatedObject(self, KKPushDelegateKey);
}

- (void)setKk_pushDelegate:(id<KKViewControllerPushDelegate>)kk_pushDelegate {
    objc_setAssociatedObject(self, KKPushDelegateKey, kk_pushDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNavBarAlpha:(CGFloat)alpha {
    
    UINavigationBar *navBar = nil;
    if ([self isKindOfClass:[KKViewController class]]) {
        KKViewController *vc = (KKViewController *)self;
        vc.kk_navigationBar.kk_navBarBackgroundAlpha = alpha;
    }else {
        navBar = self.navigationController.navigationBar;
        UIView *barBackgroundView = [navBar.subviews objectAtIndex:0]; // _UIBarBackground
        UIImageView *backgroundImageView = [barBackgroundView.subviews objectAtIndex:0]; // UIImageView
        
        if (navBar.isTranslucent) {
            if (backgroundImageView != nil && backgroundImageView.image != nil) {
                barBackgroundView.alpha = alpha;
            }else {
                UIView *backgroundEffectView = [barBackgroundView.subviews objectAtIndex:1]; // UIVisualEffectView
                if (backgroundEffectView != nil) {
                    backgroundEffectView.alpha = alpha;
                }
            }
        }else {
            barBackgroundView.alpha = alpha;
        }
    }
    // 底部分割线
    navBar.clipsToBounds = alpha == 0.0;
}

- (UIViewController *)kk_visibleViewControllerIfExist {
    
    if (self.presentedViewController) {
        return [self.presentedViewController kk_visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return [((UINavigationController *)self).topViewController kk_visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        return [((UITabBarController *)self).selectedViewController kk_visibleViewControllerIfExist];
    }
    
    if ([self isViewLoaded] && self.view.window) {
        return self;
    }else {
        NSLog(@"找不到可见的控制器，viewcontroller.self = %@, self.view.window = %@", self, self.view.window);
        return nil;
    }
}

- (void)kk_backItemClickAction:(id)sender {
    //处理范返回时,存在键盘的情况
    AppDelegate *app = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [app.window endEditing:true];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
