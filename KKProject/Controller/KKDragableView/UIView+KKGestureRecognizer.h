//
//  UIView+KKGestureRecognizer.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/30.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KKGestureRecognizer)
- (void)addTapGestureWithTarget:(id)target action:(SEL)action;
- (void)addTapGestureWithBlock:(void (^)(UIView *gestureView))aBlock;
- (void)removeTapGesture;
- (void)addTapWithGestureBlock:(void (^)(UITapGestureRecognizer *gesture))aBlock;
- (void)addTapWithDelegate:(id<UIGestureRecognizerDelegate>)delegate gestureBlock:(void (^)(UITapGestureRecognizer *gesture))aBlock;

@end

NS_ASSUME_NONNULL_END
