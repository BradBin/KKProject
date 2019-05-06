//
//  UIColor+KKAdd.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "UIColor+KKAdd.h"

@implementation UIColor (KKAdd)

+(UIColor *)randomColor{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0f
                           green:arc4random_uniform(255)/255.0f
                            blue:arc4random_uniform(255)/255.0f
                           alpha:1.0];
}

@end
