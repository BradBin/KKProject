//
//  KKPushTransitionAnimation.m
//  KKViewControllerDemo
//
//  Created by 尤彬 on 2017/7/10.
//  Copyright © 2017年 youbin. All rights reserved.
//

#import "KKPushTransitionAnimation.h"
#import "KKNavigationBarCommon.h"

@interface KKPushTransitionAnimation()

@property (nonatomic, assign) BOOL kk_scale;
@property (nonatomic, strong) UIView *kk_shadowView;

@end

@implementation KKPushTransitionAnimation

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

// 转场动画的时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

// 转场动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 获取转场容器
    UIView *containerView = [transitionContext containerView];
    // 获取转场前后的控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    // 设置转场前的frame
    toVC.view.frame = CGRectMake(_kk_ScreenWidth(), 0, _kk_ScreenWidth(), _kk_ScreenHeight());
    
    if (self.kk_scale) {
        // 初始化阴影并添加
        self.kk_shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _kk_ScreenWidth(), _kk_ScreenHeight())];
        self.kk_shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [fromVC.view addSubview:self.kk_shadowView];
    }
    
    toVC.view.layer.shadowColor   = [[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor];
    toVC.view.layer.shadowOpacity = 0.1;
    toVC.view.layer.shadowRadius  = 8;
    
    // 执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.kk_shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        if (self.kk_scale) {
            if (@available(iOS 11.0 , *)) {
                CGRect frame = fromVC.view.frame;
                frame.origin.x     = 0;
                frame.origin.y     = 0;
                frame.size.height -= 0;
                fromVC.view.frame = frame;
            }else {
                fromVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
        }else {
            fromVC.view.frame = CGRectMake(- (0.3 * _kk_ScreenWidth()), 0, _kk_ScreenWidth(), _kk_ScreenHeight());
        }
        toVC.view.frame = CGRectMake(0, 0, _kk_ScreenWidth(), _kk_ScreenHeight());
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [self.kk_shadowView removeFromSuperview];
    }];
}


@end
