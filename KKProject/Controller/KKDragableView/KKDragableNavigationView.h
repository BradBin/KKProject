//
//  KKDragableNavigationView.h
//  KKProject
//
//  Created by 尤彬 on 2019/7/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDragableView.h"

NS_ASSUME_NONNULL_BEGIN
@class KKDragableHeaderView;
@interface KKDragableNavigationView : KKDragableView

@property (nonatomic,assign) CGFloat navigationOffsetY;
@property (nonatomic,strong) KKDragableHeaderView *navigationBar;

@end


@interface KKDragableHeaderView : UIView
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIView   *titleView;
@property (nonatomic,strong) YYAnimatedImageView *bottomLineView;

@property (nonatomic,  copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
