//
//  UIView+KKPlaceHolder.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLoadingPlaceHolderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KKPlaceHolder)
@property (nonatomic,strong) KKLoadingPlaceHolderView *_Nullable placeHolderView;

- (void)kk_showPlaceHolderWithType:(KKLoadingPlaceHolderType)type callBack:(void(^)(void))callBack;
- (void)kk_showBadNetWorkWithRefreshCallBack:(void(^)(void))callBack;
    
- (void)kk_closePlaceHolder;
- (void)kk_closePlaceHolderAnimation:(BOOL)animation;
    
@end

NS_ASSUME_NONNULL_END
