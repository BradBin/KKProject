//
//  UIView+KKPlaceHolder.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "UIView+KKPlaceHolder.h"
#import <objc/runtime.h>

@implementation UIView (KKPlaceHolder)

const char loadingPlaceHolderKey;
- (KKLoadingPlaceHolderView *)placeHolderView {
    return objc_getAssociatedObject(self, &loadingPlaceHolderKey);
}
    
- (void)setPlaceHolderView:(KKLoadingPlaceHolderView *)placeHolderView {
    objc_setAssociatedObject(self, &loadingPlaceHolderKey, placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
    
    
- (void)kk_showPlaceHolderWithType:(KKLoadingPlaceHolderType)type callBack:(void(^)(void))callBack{
    if (!self.placeHolderView) {
        [self placeholder_initUI];
    }
    self.placeHolderView.type = type;
    [self.placeHolderView kk_setRefreshCB:callBack];
}
    
- (void)kk_showBadNetWorkWithRefreshCallBack:(void(^)(void))callBack {
    [self kk_showPlaceHolderWithType:KKLoadingPlaceHolderTypeBadNetwork callBack:callBack];
}
    
- (void)kk_closePlaceHolder {
    [self kk_closePlaceHolderAnimation:NO];
}
    
- (void)kk_closePlaceHolderAnimation:(BOOL)animation {
    if (!self.placeHolderView) {
        return;
    }
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            self.placeHolderView.alpha = 0.0;
        }completion:^(BOOL finished) {
            [self.placeHolderView removeFromSuperview];
            self.placeHolderView = nil;
        }];
    }else {
        self.placeHolderView.alpha = 0.0;
        [self.placeHolderView removeFromSuperview];
        self.placeHolderView = nil;
    }
}
    
- (void)placeholder_initUI {
    
    self.placeHolderView = ({
        KKLoadingPlaceHolderView *view = [[KKLoadingPlaceHolderView alloc] init];
        
        CGFloat leftMargin = 0.0;
        CGFloat TopMargin = 0.0;
        if ([self isKindOfClass:[UIScrollView class]]) {
            [self.superview addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left);
                make.top.mas_equalTo(self.mas_top).priorityLow();
                if (@available(iOS 11.0, *)) {
                    make.top.mas_greaterThanOrEqualTo(self.superview.mas_safeAreaLayoutGuideTop).priorityHigh();
                    //                    make.bottom.mas_lessThanOrEqualTo(self.superview.mas_safeAreaLayoutGuideBottom).priorityHigh();
                } else {
                    // Fallback on earlier versions
                }
                
                make.right.mas_equalTo(self.mas_right);
                make.bottom.mas_equalTo(self.mas_bottom).priorityLow();
            }];
        }else {
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(TopMargin);
                make.left.mas_equalTo(leftMargin);
                make.width.mas_equalTo(self.mas_width);
                make.height.mas_equalTo(self.mas_height);
            }];
        }
        
        view;
    });
}

@end
