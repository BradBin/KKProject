//
//  KKNavigationBar.m
//  KKViewControllerTest
//
//  Created by 尤彬 on 2017/9/20.
//  Copyright © 2017年 youbin. All rights reserved.
//

#import "KKNavigationBar.h"
#import "KKNavigationBarCommon.h"
#import "KKNavigationBarHelper.h"

@implementation KKNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置默认透明度
        self.kk_navBarBackgroundAlpha = 1.0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 这里为了适配iOS11，需要遍历所有的子控件，并向下移动状态栏的高度
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    
    if (systemVersion >= 11.0) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                CGRect frame = obj.frame;
                frame.size.height = self.frame.size.height;
                obj.frame = frame;
            }else {
                CGFloat width = [UIScreen mainScreen].bounds.size.width;
                CGFloat height = [UIScreen mainScreen].bounds.size.height;
                CGFloat y = 0;
                if (width > height) {   // 横屏
                    if (_kk_isIphoneXSeries()) {
                        y = 0;
                    }else {
                        y = self.kk_statusBarHidden ? 0 : _kk_status_height();
                    }
                }else {
                    y = self.kk_statusBarHidden ? _kk_safe_top() : _kk_status_height();
                }
                CGRect frame   = obj.frame;
                frame.origin.y = y;
                obj.frame      = frame;
            }
        }];
    }
    
    // 重新设置透明度，解决iOS11的bug
    self.kk_navBarBackgroundAlpha = self.kk_navBarBackgroundAlpha;
    
    // 显隐分割线
    [self kk_navLineHideOrShow];
    
    // 设置导航item偏移量
    
    if (@available(iOS 11.0, *)) {
        if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace) {
            self.layoutMargins = UIEdgeInsetsZero;
            
            for (UIView *subview in self.subviews) {
                if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                    // 修复iOS11 之后的偏移
                    subview.layoutMargins = UIEdgeInsetsMake(0, self.kk_navItemLeftSpace, 0, self.kk_navItemRightSpace);
                    break;
                }
            }
        }
    }
}

- (void)kk_navLineHideOrShow {
    UIView *backgroundView = self.subviews.firstObject;
    for (UIView *view in backgroundView.subviews) {
        if (view.frame.size.height <= 1.0 && view.frame.size.height > 0) {
            view.hidden = self.kk_navLineHidden;
        }
    }
}

- (void)setKk_navBarBackgroundAlpha:(CGFloat)kk_navBarBackgroundAlpha {
    _kk_navBarBackgroundAlpha = kk_navBarBackgroundAlpha;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            if (@available(iOS 10.0 , *)) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    obj.alpha = kk_navBarBackgroundAlpha;
                });
            }
        }else if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                obj.alpha = kk_navBarBackgroundAlpha;
            });
        }
    }];
    self.clipsToBounds = kk_navBarBackgroundAlpha == 0.0;
}

@end
