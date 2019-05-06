//
//  KKPopTransitionAnimation.m
//  KKViewControllerDemo
//
//  Created by 尤彬 on 2017/7/10.
//  Copyright © 2017年 youbin. All rights reserved.
//

#import "KKPopTransitionAnimation.h"
#import "KKNavigationBarCommon.h"


@interface KKPopTransitionAnimation()

@property (nonatomic, assign) BOOL kk_scale;
@property (nonatomic, strong) UIView *kk_shadowView;

@end

@implementation KKPopTransitionAnimation

+ (instancetype)kk_transitionWithScale:(BOOL)scale {
    return [[self alloc] initWithTransitionWithScale:scale];
}

- (instancetype)initWithTransitionWithScale:(BOOL)scale {
    if (self = [super init]) {
        self.kk_scale = scale;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 获取转场容器
    UIView *containerView = [transitionContext containerView];
    // 获取转场前后的控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    if (self.kk_scale) {
        // 初始化阴影图层
        self.kk_shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _kk_ScreenWidth(), _kk_ScreenHeight())];
        self.kk_shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [toVC.view addSubview:self.kk_shadowView];
        if (@available(iOS 11.0, *)) {
            CGRect frame = toVC.view.frame;
            frame.origin.x     = 0;
            frame.origin.y     = 0;
            frame.size.height -= 0;
            toVC.view.frame = frame;
        }else {
            toVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
    }else {
        fromVC.view.frame = CGRectMake(- (0.3 * _kk_ScreenWidth()), 0, _kk_ScreenWidth(), _kk_ScreenHeight());
    }
    // 添加阴影
    fromVC.view.layer.shadowColor   = [[UIColor blackColor] CGColor];
    fromVC.view.layer.shadowOpacity = 0.5;
    fromVC.view.layer.shadowRadius  = 8;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.kk_shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        fromVC.view.frame = CGRectMake(_kk_ScreenWidth(), 0, _kk_ScreenWidth(), _kk_ScreenHeight());
        if (@available(iOS 11.0 , *)) {
            toVC.view.frame = CGRectMake(0, 0, _kk_ScreenWidth(), _kk_ScreenHeight());
        }else {
            toVC.view.transform = CGAffineTransformIdentity;
        }
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [self.kk_shadowView removeFromSuperview];
    }];
}

@end
