//
//  UIBarButtonItem+KKNavigationBar.h
//  KKViewController
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KKNavigationBar)

+ (nonnull instancetype) kk_itemWithTitle:(nullable NSString *)title
                       titleColor:(nullable UIColor *) titleColor
                        imageName:(nullable UIImage *)image
                    highImageName:(nullable UIImage *)highImage
                           target:(nullable id)target
                           action:(nullable SEL)action;
@end
