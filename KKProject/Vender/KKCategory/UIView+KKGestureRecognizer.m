//
//  UIView+KKGestureRecognizer.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/30.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "UIView+KKGestureRecognizer.h"
#import <objc/runtime.h>

static NSString * const kk_view_tapGesture_block = @"kk.view.tapGesture.block";
static NSString * const kk_tapGesture_block      = @"kk.tapGesture.block";

@implementation UIView (KKGestureRecognizer)

- (void)addTapGestureWithTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

- (void)removeTapGesture{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers){
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]){
            [self removeGestureRecognizer:gesture];
        }
    }
}

- (void)addTapGestureWithBlock:(void (^)(UIView *gestureView))aBlock;{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap)];
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self, &kk_view_tapGesture_block, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)actionTap{
    void (^block)(UIView *)  = objc_getAssociatedObject(self, &kk_view_tapGesture_block);
    if (block){
        block(self);
    }
}

- (void)addTapWithGestureBlock:(void (^)(UITapGestureRecognizer *gesture))aBlock{
    [self addTapWithDelegate:nil gestureBlock:aBlock];
}

- (void)addTapWithDelegate:(id<UIGestureRecognizerDelegate>)delegate gestureBlock:(void (^)(UITapGestureRecognizer *))aBlock {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    tap.delegate = delegate;
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &kk_tapGesture_block, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)actionTap:(UITapGestureRecognizer *)aGesture{
    __weak UITapGestureRecognizer *weakGesture = aGesture;
    void (^block)(UITapGestureRecognizer *)  = objc_getAssociatedObject(self, &kk_tapGesture_block);
    if (block){
        block(weakGesture);
    }
}
@end
