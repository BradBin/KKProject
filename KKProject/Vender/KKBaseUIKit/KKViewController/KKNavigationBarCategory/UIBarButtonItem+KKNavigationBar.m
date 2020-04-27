//
//  UIBarButtonItem+KKNavigationBar.m
//  KKViewController
//
//  Created by 尤彬 on 2018/12/7.
//  Copyright © 2018年 youbin. All rights reserved.
//

#import "UIBarButtonItem+KKNavigationBar.h"

@implementation UIBarButtonItem (KKNavigationBar)

+ (instancetype) kk_itemWithTitle:(nullable NSString *)title
                       titleColor:(nullable UIColor *) titleColor
                        imageName:(nullable UIImage *)image
                    highImageName:(nullable UIImage *)highImage
                           target:(id)target
                           action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15.5];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    title = [title stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    if (title.length) [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }else{
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    if (image)   [button setImage:image forState:UIControlStateNormal];
    if (highImage) [button setImage:highImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    if (button.bounds.size.width < 44) {
        CGFloat width = 44 / button.bounds.size.height * button.bounds.size.width;
        button.bounds = CGRectMake(0, 0, width, 44);
    }
    if (button.bounds.size.height > 44) {
        CGFloat height = 44 / button.bounds.size.width * button.bounds.size.height;
        button.bounds  = CGRectMake(0, 0, 44, height);
    }
    return [[self alloc] initWithCustomView:button];
}


@end
