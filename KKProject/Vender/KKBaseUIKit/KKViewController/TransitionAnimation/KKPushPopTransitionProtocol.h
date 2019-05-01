//
//  KKPushPopTransitionProtocol.h
//  KKCustomNavigationBar
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 左滑push代理
@protocol KKViewControllerScrollPushDelegate <NSObject>

- (void)kk_scrollPushNextViewController;

@end

@class KKNavigationControllerDelegate;
// 此类用于处理UIGestureRecognizerDelegate的代理方法
@interface KKPopGestureRecognizerDelegate : NSObject<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *kk_navigationController;
// 系统返回手势的target
@property (nonatomic, weak) id kk_systemTarget;
@property (nonatomic, weak) KKNavigationControllerDelegate *kk_customTarget;

@end

// 此类用于处理UINavigationControllerDelegate的代理方法
@interface KKNavigationControllerDelegate : NSObject<UINavigationControllerDelegate>

@property (nonatomic, weak) UINavigationController *kk_navigationController;
@property (nonatomic, weak) id<KKViewControllerScrollPushDelegate> kk_pushDelegate;
// 手势Action
- (void)kk_panGestureAction:(UIPanGestureRecognizer *)gesture;

@end
