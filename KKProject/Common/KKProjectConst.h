//
//  KKProjectConst.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**************颜色自定义**************/
/**
 默认的背景颜色

 @return 背景颜色
 */
static inline UIColor *KKDefaultBackgroundViewColor(){
    return [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
}

/**
 默认的标题文本字体颜色
 
 @return 文本字体颜色
 */
static inline UIColor *KKDefaultTitleColor(){
    return [UIColor colorWithHexString:@"#1B1B1B"];
}

/**
 默认的文本字体颜色
 
 @return 文本字体颜色
 */
static inline UIColor *KKDefaultTextColor(){
    return [UIColor colorWithHexString:@"#5B5B5B"];
}

/**
 默认的描述文本字体颜色
 
 @return 文本字体颜色
 */
static inline UIColor *KKDefaultDescColor(){
    return [UIColor colorWithHexString:@"#5B5B5B"];
}


/**************字体自定义**************/
/**
 文本字体大小

 @param size size
 @return 字体大小
 */
static inline UIFont *KKDefaultFontSize(CGFloat size){
    return [UIFont systemFontOfSize:size];
}

/**
 默认的文本字体大小
 
 @return 字体大小
 */
static inline UIFont *KKDefaultFont(){
    return KKDefaultFontSize(14.0f);
}

/**
 默认的文本字体大小
 
 @return 字体大小
 */
static inline UIFont *KKDefaultTitleFont(){
    return KKDefaultFontSize(16.0f);
}

/**
 默认的描述文本字体大小
 
 @return 字体大小
 */
static inline UIFont *KKDefaultDescFont(){
    return KKDefaultFontSize(12.0f);
}




/**************常量自定义**************/

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

/**
 新闻类单张图片宽度
 
 @return 容器宽度
 */
static inline CGFloat KKLayoutContentImageWidth(){
    return ((KKLayoutContentWidth() - KKLayoutMargin() * 0.5) * 1.0f/ 3);
}


/**
 依据运行环境执行不同的block代码块

 @param block KKProject环境中执行的代码块
 @param objC_block KKProject_Objc环境中执行的代码块
 */
static inline void KKSetupBlock(dispatch_block_t block,dispatch_block_t objC_block){
#if   ENV_CODE == ENV_PROJECT
    block();
#elif ENV_CODE == ENV_PROJECT_OBJC
    objC_block();
#endif
}


static inline UIEdgeInsets KKSafeAreaInsets(){
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = UIApplication.sharedApplication.keyWindow.safeAreaInsets;
    }
    return insets;
}
