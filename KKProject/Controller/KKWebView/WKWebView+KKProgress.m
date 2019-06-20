//
//  WKWebView+KKProgress.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/20.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "WKWebView+KKProgress.h"
#import <objc/runtime.h>


@interface WKWebView()

@end

@implementation WKWebView (KKProgress)

-(UIView *)progessView{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setProgessView:(UIView *)progessView{
    if (self.progessView) {
        [self.progessView removeFromSuperview];
    }
    objc_setAssociatedObject(self, @selector(progessView), progessView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
