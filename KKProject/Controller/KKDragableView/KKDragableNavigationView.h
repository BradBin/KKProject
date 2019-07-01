//
//  KKDragableNavigationView.h
//  KKProject
//
//  Created by 尤彬 on 2019/7/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDragableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKDragableNavigationView : KKDragableView

@property (nonatomic,assign) CGFloat navigationOffsetY;
@property (nonatomic,strong) UIView *navigationBar;

@end

NS_ASSUME_NONNULL_END
