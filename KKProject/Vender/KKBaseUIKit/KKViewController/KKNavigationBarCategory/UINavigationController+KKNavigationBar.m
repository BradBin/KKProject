//
//  UINavigationController+KKNavigationBar.m
//  KKCustomNavigationBar
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//

#import "UINavigationController+KKNavigationBar.h"
#import "AppDelegate.h"
#import "KKViewController.h"
#import <objc/runtime.h>

@implementation UINavigationController (KKNavigationBar)

+ (instancetype)kk_rooterViewController:(UIViewController *)rooterViewController translationScale:(BOOL)translationScale {
    return [[self alloc] initWithrooterViewController:rooterViewController translationScale:translationScale];
}

- (instancetype)initWithrooterViewController:(UIViewController *)rooterViewController translationScale:(BOOL)translationScale {
    if (self = [super init]) {
        [self pushViewController:rooterViewController animated:YES];
        self.kk_translationScale = translationScale;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}
// 方法交换
+ (void)load {
    // 保证其只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        _kk_swizzled_method(class,
                            @selector(viewDidLoad),
                            @selector(kk_viewDidLoad));
        // FIXME: 修复iOS11之后push或pop动画为NO，系统不主动调用UINavigationBar的layoutSubviews方法
        if (@available(iOS 11.0 , *)) {
            _kk_swizzled_method(class,
                                @selector(pushViewController:animated:),
                                @selector(kk_pushViewController:animated:));
            _kk_swizzled_method(class,
                                @selector(popViewControllerAnimated:),
                                @selector(kk_popViewControllerAnimated:));
            _kk_swizzled_method(class,
                                @selector(popToViewController:animated:),
                                @selector(kk_popToViewController:animated:));
            _kk_swizzled_method(class,
                                @selector(popToRootViewControllerAnimated:),
                                @selector(kk_popToRootViewControllerAnimated:));
            _kk_swizzled_method(class,
                                @selector(setViewControllers:animated:),
                                @selector(kk_setViewControllers:animated:));
        }
    });
}

- (void)kk_viewDidLoad {
    // 处理特殊控制器
    if ([self isKindOfClass:[UIImagePickerController class]]) return;
    if ([self isKindOfClass:[UIVideoEditorController class]]) return;
    // 设置代理和通知
    // 设置背景色
    self.view.backgroundColor = [UIColor grayColor];
    // 设置代理
    self.delegate = self.navDelegate;
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:KKViewControllerPropertyChangedNotification object:nil];
    [self kk_viewDidLoad];
}

// FIXME: 修复iOS11之后push或pop动画为NO，系统不主动调用UINavigationBar的layoutSubviews方法
- (void)kk_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //处理范返回时,存在键盘的情况
    AppDelegate *app = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [app.window endEditing:true];
    [self kk_pushViewController:viewController animated:animated];
    if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace) {
        if (!animated) {
            [self kk_layoutNavBarWithViewController:viewController];
        }
    }
}

- (nullable UIViewController *)kk_popViewControllerAnimated:(BOOL)animated {
    UIViewController *vc = [self kk_popViewControllerAnimated:animated];
    if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace) {
        if (!animated) {
            [self kk_layoutNavBarWithViewController:vc];
        }
    }
    return vc;
}

- (nullable NSArray<__kindof UIViewController *> *)kk_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *vcs = [self kk_popToViewController:viewController animated:animated];
    if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace) {
        if (!animated) {
            [self kk_layoutNavBarWithViewController:self.visibleViewController];
        }
    }
    return vcs;
}

- (NSArray<UIViewController *> *)kk_popToRootViewControllerAnimated:(BOOL)animated {
    NSArray *vcs = [self kk_popToRootViewControllerAnimated:animated];
    if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace) {
        if (!animated) {
            [self kk_layoutNavBarWithViewController:self.visibleViewController];
        }
    }
    return vcs;
}

- (void)kk_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [self kk_setViewControllers:viewControllers animated:animated];
    if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace) {
        if (!animated) {
            [self kk_layoutNavBarWithViewController:self.visibleViewController];
        }
    }
}

- (void)kk_layoutNavBarWithViewController:(UIViewController *)viewController {
    UINavigationBar *navBar = nil;
    if ([viewController isKindOfClass:[KKViewController class]]) {
        KKViewController *vc = (KKViewController *)viewController;
        navBar = vc.kk_navigationBar;
    }else {
        navBar = self.navigationBar;
    }
    [navBar layoutSubviews];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KKViewControllerPropertyChangedNotification object:nil];
}

#pragma mark - Notification Handle
- (void)handleNotification:(NSNotification *)notify {
    
    UIViewController *vc = (UIViewController *)notify.object[@"viewController"];
    BOOL isrooterViewController = vc == self.viewControllers.firstObject;
    if (vc.kk_interactivePopDisabled) { // 禁止滑动
        self.interactivePopGestureRecognizer.delegate = nil;
        self.interactivePopGestureRecognizer.enabled = NO;
    }else if (vc.kk_fullScreenPopDisabled) { // 禁止全屏滑动
        [self.interactivePopGestureRecognizer.view removeGestureRecognizer:self.panGesture];
        if (self.kk_translationScale) {
            self.interactivePopGestureRecognizer.delegate = nil;
            self.interactivePopGestureRecognizer.enabled = NO;
            if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.screenPanGesture]) {
                [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.screenPanGesture];
                self.screenPanGesture.delegate = self.popGestureDelegate;
            }
        }else {
            self.interactivePopGestureRecognizer.delaysTouchesBegan = YES;
            self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
            self.interactivePopGestureRecognizer.enabled = !isrooterViewController;
        }
    }else {
        self.interactivePopGestureRecognizer.delegate = nil;
        self.interactivePopGestureRecognizer.enabled = NO;
        [self.interactivePopGestureRecognizer.view removeGestureRecognizer:self.screenPanGesture];
        
        if (!isrooterViewController && ![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.panGesture]) {
            [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.panGesture];
            self.panGesture.delegate = self.popGestureDelegate;
        }
        if (self.kk_translationScale || self.kk_openScrollLeftPush) {
            [self.panGesture addTarget:self.navDelegate action:@selector(kk_panGestureAction:)];
        }else {
            SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
            [self.panGesture addTarget:[self _kk_systemTarget] action:internalAction];
        }
    }
}

#pragma mark - StatusBar
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

- (BOOL)prefersStatusBarHidden {
    return self.visibleViewController.kk_statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.visibleViewController.kk_statusBarStyle;
}

#pragma mark - getter
- (BOOL)kk_translationScale {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)kk_openScrollLeftPush {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (KKPopGestureRecognizerDelegate *)popGestureDelegate {
    KKPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [KKPopGestureRecognizerDelegate new];
        delegate.kk_navigationController = self;
        delegate.kk_systemTarget         = [self _kk_systemTarget];
        delegate.kk_customTarget         = self.navDelegate;
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (KKNavigationControllerDelegate *)navDelegate {
    KKNavigationControllerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [KKNavigationControllerDelegate new];
        delegate.kk_navigationController = self;
        delegate.kk_pushDelegate         = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (UIScreenEdgePanGestureRecognizer *)screenPanGesture {
    UIScreenEdgePanGestureRecognizer *panGesture = objc_getAssociatedObject(self, _cmd);
    if (!panGesture) {
        panGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.navDelegate action:@selector(kk_panGestureAction:)];
        panGesture.edges = UIRectEdgeLeft;
        
        objc_setAssociatedObject(self, _cmd, panGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGesture;
}

- (UIPanGestureRecognizer *)panGesture {
    UIPanGestureRecognizer *panGesture = objc_getAssociatedObject(self, _cmd);
    if (!panGesture) {
        panGesture = [[UIPanGestureRecognizer alloc] init];
        panGesture.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGesture;
}

- (id)_kk_systemTarget {
    NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
    id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
    
    return internalTarget;
}

#pragma mark - setter
- (void)setKk_translationScale:(BOOL)kk_translationScale {
    objc_setAssociatedObject(self, @selector(kk_translationScale), @(kk_translationScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKk_openScrollLeftPush:(BOOL)kk_openScrollLeftPush {
    objc_setAssociatedObject(self, @selector(kk_openScrollLeftPush), @(kk_openScrollLeftPush), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - KKViewControllerScrollPushDelegate
- (void)kk_scrollPushNextViewController {
    // 获取当前控制器
    UIViewController *currentVC = self.visibleViewController;
    
    if ([currentVC.kk_pushDelegate respondsToSelector:@selector(kk_pushToNextViewController)]) {
        [currentVC.kk_pushDelegate kk_pushToNextViewController];
    }
}

@end
