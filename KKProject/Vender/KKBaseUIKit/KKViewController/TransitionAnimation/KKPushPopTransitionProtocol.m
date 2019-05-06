//
//  KKPushPopTransitionProtocol.m
//  KKCustomNavigationBar
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//

#import "KKPushPopTransitionProtocol.h"
#import "UIViewController+KKNavigationBar.h"
#import "UINavigationController+KKNavigationBar.h"
#import "KKPushTransitionAnimation.h"
#import "KKPopTransitionAnimation.h"
#import "AppDelegate.h"

@implementation KKPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (self.kk_navigationController.kk_openScrollLeftPush) {
        // 开启了左滑push功能
    }else {
        // 忽略根控制器
        if (self.kk_navigationController.viewControllers.count <= 1) {
            return NO;
        }
    }
    // 忽略禁用手势
    UIViewController *topVC = self.kk_navigationController.viewControllers.lastObject;
    if (topVC.kk_interactivePopDisabled) return NO;
    CGPoint transition = [gestureRecognizer translationInView:gestureRecognizer.view];
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    if (transition.x < 0) {
        if (self.kk_navigationController.kk_openScrollLeftPush) {
            [gestureRecognizer removeTarget:self.kk_systemTarget action:action];
            [gestureRecognizer addTarget:self.kk_customTarget action:@selector(kk_panGestureAction:)];
        }else {
            return NO;
        }
    }else {
        // 全屏滑动时起作用
        if (!topVC.kk_fullScreenPopDisabled) {
            // 上下滑动
            if (transition.x == 0) return NO;
        }
        // 忽略超出手势区域
        CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
        CGFloat maxAllowDistance  = topVC.kk_popMaxAllowedDistanceToLeftEdge;
        if (maxAllowDistance > 0 && beginningLocation.x > maxAllowDistance) {
            return NO;
        }else if(!self.kk_navigationController.kk_translationScale) { // 非缩放，系统处理
            [gestureRecognizer removeTarget:self.kk_customTarget action:@selector(kk_panGestureAction:)];
            [gestureRecognizer addTarget:self.kk_systemTarget action:action];
        }else {
            [gestureRecognizer removeTarget:self.kk_systemTarget action:action];
            [gestureRecognizer addTarget:self.kk_customTarget action:@selector(kk_panGestureAction:)];
        }
    }
    // 忽略导航控制器正在做转场动画
    if ([[self.kk_navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"KKHomeLiveControl"] ||
        [NSStringFromClass([touch.view class]) isEqualToString:@"KKAudioPlayControl"]) {
        // 不需要响应
        return NO;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] ||
        [NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionViewCell"] ||
        [NSStringFromClass([touch.view class]) isEqualToString:@"YYLabel"] ||
        [NSStringFromClass([touch.view class]) isEqualToString:@"_UITableViewHeaderFooterContentView"] ||
        [NSStringFromClass([touch.view class]) isEqualToString:@"YYTextContainerView"] ||
        [NSStringFromClass([touch.view class]) isEqualToString:@"YYTextView"]
        ) {
        // 不需要响应
        return NO;
    }
    return YES;
}

@end

@interface KKNavigationControllerDelegate()

@property (nonatomic, assign) BOOL kk_isGesturePush;
// push动画的百分比
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *kk_pushTransition;
// pop动画的百分比
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *kk_popTransition;

@end

@implementation KKNavigationControllerDelegate

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if ((self.kk_navigationController.kk_translationScale) || (self.kk_navigationController.kk_openScrollLeftPush && self.kk_pushTransition)) {
        if (operation == UINavigationControllerOperationPush) {
            return [KKPushTransitionAnimation kk_transitionWithScale:self.kk_navigationController.kk_translationScale];
        }else if (operation == UINavigationControllerOperationPop) {
            return [KKPopTransitionAnimation kk_transitionWithScale:self.kk_navigationController.kk_translationScale];
        }
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if ((self.kk_navigationController.kk_translationScale) || (self.kk_navigationController.kk_openScrollLeftPush && self.kk_pushTransition)) {
        
        if ([animationController isKindOfClass:[KKPopTransitionAnimation class]]) {
            return self.kk_popTransition;
        }else if ([animationController isKindOfClass:[KKPushTransitionAnimation class]]) {
            return self.kk_pushTransition;
        }
    }
    
    return nil;
}

#pragma mark - 滑动手势处理
- (void)kk_panGestureAction:(UIPanGestureRecognizer *)gesture {
    
    //处理范返回时,存在键盘的情况
    AppDelegate *app = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [app.window endEditing:true];
    
    // 进度
    CGFloat progress    = [gesture translationInView:gesture.view].x / gesture.view.bounds.size.width;
    CGPoint translation = [gesture velocityInView:gesture.view];
    
    // 在手势开始的时候判断是push操作还是pop操作
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.kk_isGesturePush = translation.x < 0 ? YES : NO;
    }
    
    // push时 progress < 0 需要做处理
    if (self.kk_isGesturePush) {
        progress = -progress;
    }
    
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (self.kk_isGesturePush) {
            if (self.kk_navigationController.kk_openScrollLeftPush && [self.kk_pushDelegate respondsToSelector:@selector(kk_scrollPushNextViewController)]) {
                self.kk_pushTransition = [UIPercentDrivenInteractiveTransition new];
                self.kk_pushTransition.completionCurve = UIViewAnimationCurveEaseOut;
                
                [self.kk_pushDelegate kk_scrollPushNextViewController];
                [self.kk_pushTransition updateInteractiveTransition:0];
            }
        }else {
            self.kk_popTransition = [UIPercentDrivenInteractiveTransition new];
            [self.kk_navigationController popViewControllerAnimated:YES];
        }
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        if (self.kk_isGesturePush) {
            if (self.kk_navigationController.kk_openScrollLeftPush) {
                [self.kk_pushTransition updateInteractiveTransition:progress];
            }
        }else {
            [self.kk_popTransition updateInteractiveTransition:progress];
        }
    }else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (self.kk_isGesturePush) {
            if (self.kk_navigationController.kk_openScrollLeftPush) {
                if (progress > 0.3) {
                    [self.kk_pushTransition finishInteractiveTransition];
                }else {
                    [self.kk_pushTransition cancelInteractiveTransition];
                }
            }
        }else {
            if (progress > 0.5) {
                [self.kk_popTransition finishInteractiveTransition];
            }else {
                [self.kk_popTransition cancelInteractiveTransition];
            }
        }
        self.kk_pushTransition = nil;
        self.kk_popTransition  = nil;
        self.kk_isGesturePush  = NO;
    }
}

@end
