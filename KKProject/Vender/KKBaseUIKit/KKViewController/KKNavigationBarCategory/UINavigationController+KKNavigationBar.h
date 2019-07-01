//
//  UINavigationController+KKNavigationBar.h
//  KKCustomNavigationBar
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+KKNavigationBar.h"
#import "UIBarButtonItem+KKNavigationBar.h"
#import "KKPushPopTransitionProtocol.h"

@interface UINavigationController (KKNavigationBar)<KKViewControllerScrollPushDelegate>

/**
 初始化UINavigationController实例对象

 @param rooterViewController rooterViewController
 @param translationScale translationScale
 @return UINavigationController实例对象
 */
+ (instancetype) kk_rooterViewController:(UIViewController *)rooterViewController translationScale:(BOOL)translationScale;

/**
 导航栏转场时是否缩放,此属性只能在初始化导航栏的时候有效，在其他地方设置会导致错乱
 */
@property (nonatomic, assign, readonly) BOOL kk_translationScale;

/**
 是否开启左滑push操作，默认是NO，此时不可禁用控制器的滑动返回手势
 */
@property (nonatomic, assign) BOOL kk_openScrollLeftPush;

@end
