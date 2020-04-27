//
//  UIView+MBProgressHUD.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/14.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#if __has_include(<MBProgressHUD/MBProgressHUD.h>)
#import <MBProgressHUD/MBProgressHUD.h>
#else
#import "MBProgressHUD/MBProgressHUD.h"
#endif

NS_ASSUME_NONNULL_BEGIN



@interface UIView (MBProgressHUD)

/**
 *  只带文字提示
 *
 *  @param title 提示字符
 */
- (void)showTitle:(NSString *)title;
- (void)showTitle:(NSString *)title navigationBar:(BOOL)hiden;
- (void)showTitle:(NSString *)title yOffset:(CGFloat)y;
- (void)showTitle:(NSString *)title completion:(void(^)(void))completion;

/**
 *  菊花加载
 *
 *
 */
- (void)showLoadMessageAtCenter;
- (void)showLoadMessageAtCenter:(NSString *)title;
- (void)showLoadMessageAtCenter:(NSString *)title navigationBar:(BOOL)hiden;
- (void)showLoadMessageAtCenter:(NSString *)title yOffset:(CGFloat)y;
//以下为透明菊花
- (void)showClearLoadMessageAtCenter;
- (void)showClearLoadMessageAtCenter:(NSString *)title;
- (void)showClearLoadMessageAtCenter:(NSString *)title navigationBar:(BOOL)hiden;
- (void)showClearLoadMessageAtCenter:(NSString *)title yOffset:(CGFloat)y;

/**
 *  网络请求成功
 *
 *  @param title 提示字符
 */
- (void)showSuccess:(NSString *)title;
- (void)showSuccess:(NSString *)title navigationBar:(BOOL)hiden;
- (void)showSuccess:(NSString *)title yOffset:(CGFloat)y;

/**
 *  网络请求失败
 *
 *  @param title 提示字符
 */
- (void)showError:(NSString *)title;
- (void)showError:(NSString *)title navigationBar:(BOOL)hiden;
- (void)showError:(NSString *)title yOffset:(CGFloat)y;


- (void)hide DEPRECATED_MSG_ATTRIBUTE("请使用kk_hideProgressHUD");
/**
 *  隐藏
 */
- (void)kk_hideProgressHUD;
- (void)kk_hideProgressHUDAnimated:(BOOL)animated;


+ (void)showLoadMessageAtCenter;
+ (void)showClearLoadMessageAtCenter;
+ (void)showSuccess:(NSString *)title;
+ (void)showError:(NSString *)title;
+ (void)showTitle:(NSString *)title;
+ (void)showTitle:(NSString *)title completion:(void(^)(void))completion;;
+ (void)kk_hideProgressHUD;
+ (void)kk_hideProgressHUDAnimated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
