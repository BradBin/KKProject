//
//  KKNavigationBar.h
//  KKViewControllerTest
//
//  Created by 尤彬 on 2017/9/20.
//  Copyright © 2017年 youbin. All rights reserved.
//  自定义的导航条

#import <UIKit/UIKit.h>

@interface KKNavigationBar : UINavigationBar

// 当前控制器
@property (nonatomic, assign) BOOL      kk_statusBarHidden;
/** 导航栏背景色透明度，默认是1.0 */
@property (nonatomic, assign) CGFloat   kk_navBarBackgroundAlpha;
@property (nonatomic, assign) BOOL      kk_navLineHidden;

// 左边item间距
@property (nonatomic, assign) CGFloat   kk_navItemLeftSpace;
// 右边item间距
@property (nonatomic, assign) CGFloat   kk_navItemRightSpace;

- (void)kk_navLineHideOrShow;

@end
