//
//  KKPushTransitionAnimation.h
//  KKViewControllerDemo
//
//  Created by 尤彬 on 2017/7/10.
//  Copyright © 2017年 youbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPushTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)kk_transitionWithScale:(BOOL)scale;

@end
