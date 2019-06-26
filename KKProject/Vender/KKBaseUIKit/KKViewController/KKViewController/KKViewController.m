//
//  KKViewController.m
//  KKViewController
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//

#import "KKViewController.h"
#import "KKNavigationBarHelper.h"


@interface KKViewController ()

@property (nonatomic, strong) KKNavigationBar   *kk_navigationBar;
@property (nonatomic, strong) UINavigationItem  *kk_navigationItem;
@property (nonatomic, assign) CGFloat           last_navItemLeftSpace;
@property (nonatomic, assign) CGFloat           last_navItemRightSpace;

@end

@implementation KKViewController


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    KKViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController);
        [viewController kk_addSubviews];
        [viewController kk_layoutNavigation];
        [viewController kk_bindViewModel];  //绑定信号 备注:注意先绑定信号--->再执行信号
        [viewController kk_executeViewModel]; //执行信号 备注:注意先绑定信号--->再执行信号
    }];
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController kk_setupConfigurate];
    }];
    return viewController;
}


-(instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    return [super init];
}

#pragma mark - KKViewControllerProtocol

/**
 需要登录
 */
-(void)kk_needRelogin{}

/**
 创建并布局视图
 */
-(void)kk_addSubviews{}

/**
 配置属性
 */
- (void)kk_setupConfigurate{};

/**
 绑定数据
 */
-(void)kk_bindViewModel{};

/**
 设置导航栏
 */
-(void)kk_layoutNavigation{}

/**
 初次获取数据
 */
-(void)kk_executeViewModel{}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationCapturesStatusBarAppearance = false;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = false;
    self.navigationController.navigationBar.translucent = false;
    [self setupCustomNavBar];
    [self setupNavBarAppearance];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    // 将自定义导航栏放置顶层
    if (self.kk_navigationBar && !self.kk_navigationBar.hidden) {
        [self.view bringSubviewToFront:self.kk_navigationBar];
    }
    // 重置navitem_space
    [[KKNavigationBarHelper sharedInstance] kk_updateConfigure:^(KKNavigationBarHelper *configure) {
        configure.kk_navItemLeftSpace   = self.kk_navItemLeftSpace;
        configure.kk_navItemRightSpace  = self.kk_navItemRightSpace;
    }];
    // 获取状态
    self.kk_navigationBar.kk_statusBarHidden = self.kk_statusBarHidden;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 重置navitem_space
    [[KKNavigationBarHelper sharedInstance] kk_updateConfigure:^(KKNavigationBarHelper *configure) {
        configure.kk_navItemLeftSpace  = self.last_navItemLeftSpace;
        configure.kk_navItemRightSpace = self.last_navItemRightSpace;
    }];
}

#pragma mark - Public Methods
- (void)kk_showNavLine {
    self.kk_navLineHidden = NO;
}

- (void)kk_hideNavLine {
    self.kk_navLineHidden = YES;
}

#pragma mark - private Methods
/**
 设置自定义导航条
 */
- (void)setupCustomNavBar {
    
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
//    }else{
//       self.automaticallyAdjustsScrollViewInsets = NO;
//    }

    [self.view addSubview:self.kk_navigationBar];
    [self setupNavBarFrame];
    self.kk_navigationBar.items = @[self.kk_navigationItem];
}

/**
 设置导航栏外观
 */
- (void)setupNavBarAppearance {
    
    KKNavigationBarHelper *configure = [KKNavigationBarHelper sharedInstance];
    if (configure.kk_backgroundColor) self.kk_navBackgroundColor = configure.kk_backgroundColor;
    if (configure.kk_titleColor)      self.kk_navTitleColor      = configure.kk_titleColor;
    if (configure.kk_titleFont)       self.kk_navTitleFont       = configure.kk_titleFont;
    
    self.kk_statusBarHidden     = configure.kk_statusBarHidden;
    self.kk_statusBarStyle      = configure.kk_statusBarStyle;
    self.kk_backStyle           = configure.kk_backStyle;
    
    self.kk_navItemLeftSpace    = configure.kk_navItemLeftSpace;
    self.kk_navItemRightSpace   = configure.kk_navItemRightSpace;
    
    self.last_navItemLeftSpace  = configure.kk_navItemLeftSpace;
    self.last_navItemRightSpace = configure.kk_navItemRightSpace;
    
}



- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setupNavBarFrame];
}

- (void)setupNavBarFrame {
    CGFloat width  = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat navBarH = 0;
    if (width > height) { // 横屏
        if (_kk_isIphoneXSeries()) {
            navBarH = _kk_navBar_height();
        }else {
            if (width == 736.0f && height == 414.0f) { // plus横屏
                navBarH = self.kk_statusBarHidden ? _kk_navBar_height() : _kk_nav_height();
            }else { // 其他机型横屏
                navBarH = self.kk_statusBarHidden ? 32.0f : 52.0f;
            }
        }
    }else { // 竖屏
        navBarH = self.kk_statusBarHidden ? _kk_safe_top() + _kk_navBar_height() : _kk_nav_height();
    }
    self.kk_navigationBar.frame = CGRectMake(0, 0, width, navBarH);
}

#pragma mark - 控制屏幕旋转的方法
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark - 控制状态栏的方法
- (BOOL)prefersStatusBarHidden {
    return self.kk_statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.kk_statusBarStyle;
}

#pragma mark - 懒加载
- (KKNavigationBar *)kk_navigationBar {
    if (_kk_navigationBar == nil) {
        _kk_navigationBar = [[KKNavigationBar alloc] initWithFrame:CGRectZero];
    }
    return _kk_navigationBar;
}

- (UINavigationItem *)kk_navigationItem {
    if (_kk_navigationItem == nil) {
        _kk_navigationItem = [UINavigationItem new];
    }
    return _kk_navigationItem;
}

#pragma mark - setter
- (void)setKk_navTitle:(NSString *)kk_navTitle {
    _kk_navTitle = kk_navTitle;
    self.kk_navigationItem.title = kk_navTitle;
}

- (void)setKk_navBarTintColor:(UIColor *)kk_navBarTintColor {
    _kk_navBarTintColor = kk_navBarTintColor;
    self.kk_navigationBar.barTintColor = kk_navBarTintColor;
}

- (void)setKk_navBackgroundColor:(UIColor *)kk_navBackgroundColor {
    _kk_navBackgroundColor = kk_navBackgroundColor;
    if (kk_navBackgroundColor == [UIColor clearColor]) {
        [self.kk_navigationBar setBackgroundImage:[UIImage imageNamed:@"KKNavigationBar.bundle/transparent_bg.png"] forBarMetrics:UIBarMetricsDefault];
        self.kk_navShadowImage = [self _kk_imageWithColor:[UIColor clearColor]];
    }else {
        [self.kk_navigationBar setBackgroundImage:[self _kk_imageWithColor:kk_navBackgroundColor] forBarMetrics:UIBarMetricsDefault];
        UIImage *shadowImage = nil;
        if (self.kk_navShadowImage) {
            shadowImage = self.kk_navShadowImage;
        }else if (self.kk_navShadowColor) {
            shadowImage = [self _kk_imageWithColor:self.kk_navShadowColor size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
        }
        self.kk_navShadowImage = shadowImage;
    }
}

- (void)setKk_navBackgroundImage:(UIImage *)kk_navBackgroundImage {
    _kk_navBackgroundImage = kk_navBackgroundImage;
    [self.kk_navigationBar setBackgroundImage:kk_navBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)setKk_navShadowColor:(UIColor *)kk_navShadowColor {
    _kk_navShadowColor = kk_navShadowColor;
    self.kk_navigationBar.shadowImage = [self _kk_imageWithColor:kk_navShadowColor size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
}

- (void)setKk_navShadowImage:(UIImage *)kk_navShadowImage {
    _kk_navShadowImage = kk_navShadowImage;
    self.kk_navigationBar.shadowImage = kk_navShadowImage;
}

- (void)setKk_navTintColor:(UIColor *)kk_navTintColor {
    _kk_navTintColor = kk_navTintColor;
    self.kk_navigationBar.tintColor = kk_navTintColor;
}

- (void)setKk_navTitleView:(UIView *)kk_navTitleView {
    _kk_navTitleView = kk_navTitleView;
    self.kk_navigationItem.titleView = kk_navTitleView;
}

- (void)setKk_navTitleColor:(UIColor *)kk_navTitleColor {
    _kk_navTitleColor = kk_navTitleColor;
    UIFont *titleFont = self.kk_navTitleFont ? self.kk_navTitleFont : [KKNavigationBarHelper sharedInstance].kk_titleFont;
    self.kk_navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: kk_navTitleColor, NSFontAttributeName: titleFont};
}

- (void)setKk_navTitleFont:(UIFont *)kk_navTitleFont {
    _kk_navTitleFont = kk_navTitleFont;
    UIColor *titleColor = self.kk_navTitleColor ? self.kk_navTitleColor : [KKNavigationBarHelper sharedInstance].kk_titleColor;
    self.kk_navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: titleColor, NSFontAttributeName: kk_navTitleFont};
}

- (void)setKk_navLeftBarButtonItem:(UIBarButtonItem *)kk_navLeftBarButtonItem {
    _kk_navLeftBarButtonItem = kk_navLeftBarButtonItem;
    self.kk_navigationItem.leftBarButtonItem = kk_navLeftBarButtonItem;
}

- (void)setKk_navLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)kk_navLeftBarButtonItems {
    _kk_navLeftBarButtonItems = kk_navLeftBarButtonItems;
    self.kk_navigationItem.leftBarButtonItems = kk_navLeftBarButtonItems;
}

- (void)setKk_navRightBarButtonItem:(UIBarButtonItem *)kk_navRightBarButtonItem {
    _kk_navRightBarButtonItem = kk_navRightBarButtonItem;
    self.kk_navigationItem.rightBarButtonItem = kk_navRightBarButtonItem;
}

- (void)setKk_navRightBarButtonItems:(NSArray<UIBarButtonItem *> *)kk_navRightBarButtonItems {
    _kk_navRightBarButtonItems = kk_navRightBarButtonItems;
    self.kk_navigationItem.rightBarButtonItems = kk_navRightBarButtonItems;
}

- (void)setKk_navItemLeftSpace:(CGFloat)kk_navItemLeftSpace {
    _kk_navItemLeftSpace = kk_navItemLeftSpace;
    self.kk_navigationBar.kk_navItemLeftSpace = kk_navItemLeftSpace;
}

- (void)setKk_navItemRightSpace:(CGFloat)kk_navItemRightSpace {
    _kk_navItemRightSpace = kk_navItemRightSpace;
    self.kk_navigationBar.kk_navItemRightSpace = kk_navItemRightSpace;
}

- (void)setKk_navLineHidden:(BOOL)kk_navLineHidden {
    _kk_navLineHidden = kk_navLineHidden;
    self.kk_navigationBar.kk_navLineHidden = kk_navLineHidden;
    // 暂时的处理方法
    if (@available(iOS 11, *)) {
        self.kk_navShadowImage = kk_navLineHidden ? [UIImage new] : self.kk_navShadowImage;
    }
    [self.kk_navigationBar layoutSubviews];
}

- (UIImage *)_kk_imageWithColor:(UIColor *)color {
    return [self _kk_imageWithColor:color size:CGSizeMake(1.0, 1.0)];
}

- (UIImage *) _kk_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc{
   
}

//显示loading状态
- (void)kk_showLoading {
   
    [self.view kk_showPlaceHolderWithType:KKLoadingPlaceHolderTypeLoading callBack:^{
        [self kk_refreshWhenFailed];
    }];
}
//显示加载失败状态
- (void)kk_showFailed {
    self.view.placeHolderView.type = KKLoadingPlaceHolderTypeFailed;
}
//关闭加载状态
- (void)kk_closePlaceHolder {
    [self.view kk_closePlaceHolder];
}
//重写老刷新加载失败
- (void)kk_refreshWhenFailed {
    
}

@end

