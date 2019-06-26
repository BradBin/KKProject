//
//  KKProjectConst.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 默认的背景颜色

 @return 默认的背景颜色
 */
static inline UIColor *KKDefaultBackgroundViewColor(){
    return [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
}

/**
 屏幕宽度

 @return 屏幕宽度
 */
static inline CGFloat KKScreenWidth(){
    return UIScreen.mainScreen.bounds.size.width;
}

/**
 屏幕高度
 
 @return 屏幕高度
 */
static inline CGFloat KKScreenHeight(){
    return UIScreen.mainScreen.bounds.size.height;
}

/**
 内容边距

 @return 内容边距
 */
static inline CGFloat KKLayoutMargin(){
    return CGFloatPixelRound(16.0f);
}

/**
 容器宽度
 
 @return 容器宽度
 */
static inline CGFloat KKLayoutContentWidth(){
    return (KKScreenWidth() - KKLayoutMargin() * 2);
}
