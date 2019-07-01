//
//  KKDragableView.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/29.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KKViewTag) {
    KKViewTagPersonInfoScrollView = 100000 ,//他人信息(动态，文章等视图的父视图)scrollview的tag，主要用于解决手势冲突
    KKViewTagRecognizeSimultaneousTableView,//他人信息最外层tableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoDongTai ,//他人信息动态视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoArtical ,//他人信息文章视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoVideo ,//他人信息视频视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoWenDa ,//他人信息问答视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoRelease ,//他人信息发布厅视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoMatrix ,//他人信息矩阵视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagUserCenterView ,//个人中心的uitableview的tag，主要用于解决手势冲突
    KKViewTagImageDetailView ,//相片预览视图tag，主要用于解决手势冲突
    KKViewTagImageDetailDescView ,//相片描述视图tag，主要用于解决手势冲突
};


/**
 视图显示的动画效果

 - KKShowViewTypeNone: None
 - KKShowViewTypePush: push
 - KKShowViewTypePopup: Popup
 */
typedef NS_ENUM(NSUInteger,KKShowViewType) {
    KKShowViewTypeNone = 0,
    KKShowViewTypePush,
    KKShowViewTypePopup
};

typedef NS_ENUM(NSUInteger,KKMoveDirection) {
    KKMoveDirectionNone = 0,
    KKMoveDirectionUp,
    KKMoveDirectionDown,
    KKMoveDirectionLeft,
    KKMoveDirectionRight
};

@interface KKDragableView : UIView

/**
 拖动手势的方向
 */
@property(nonatomic,assign,readonly) KKMoveDirection dragDirection;

/**
 视图显示的类型
 */
@property(nonatomic,assign,readonly) KKShowViewType showViewType;

/**
 背景视图
 */
@property(nonatomic,strong,readonly) UIView *dragBackgroundView;

/**
 内容容器视图
 */
@property(nonatomic,strong,readonly) UIView *dragContentView;

@property(nonatomic,assign) CGFloat topSpace ;//dragContentView的顶部距离屏幕上方的距离
@property(nonatomic,assign) CGFloat contentViewCornerRadius;//dragContentView的圆角
@property(nonatomic,assign) UIRectCorner cornerEdge;//设定dragContentView的哪些边需要圆角

@property(nonatomic,assign) BOOL enableHorizonDrag;//是否允许水平拖拽，默认为YES
@property(nonatomic,assign) BOOL enableVerticalDrag;//是否允许垂直拖拽，默认为YES
@property(nonatomic,assign) BOOL enableFreedomDrag;//允许自由拖拽,默认为NO,设为YES，则enableHorizonDrag、enableVerticalDrag自动失效
@property(nonatomic,assign) BOOL defaultHideAnimateWhenDragFreedom;//自由拖拽时，是否使用默认的隐藏动画，默认为YES



- (void)setupView;

/**
 视图将要显示时,执行的方法
 */
- (void)viewWillAppear;

/**
 视图显示已完成,执行的方法
 */
- (void)viewDidAppear;

/**
 视图将要消失时,执行的方法
 */
- (void)viewWillDisappear;

/**
 视图已经消失,执行的方法
 */
- (void)viewDidDisappear;

/**
 更新视图的属性

 @param block block
 */
- (void)updateBackgroundView:(void(^)(KKDragableView *view))block;

#pragma mark -- 显示与隐藏动画

- (void)startShow;
- (void)startHide;


/**
 popup视图

 @param animated true:开启动画  otherwise:关闭动画
 */
- (void)popUpViewWithAnimated:(BOOL)animated;

/**
 是否允许popup视图,可以向上popOut

 @param toTop  true:允许 otherwise:不允许
 */
- (void)popOutToTop:(BOOL)toTop;

/**
 push视图

 @param animated true:开启动画  otherwise:关闭动画
 */
- (void)pushViewWithAnimated:(BOOL)animated;

/**
 是否允许向右pushOut视图

 @param toRight true:允许 otherwise:不允许
 */
- (void)pushOutToRight:(BOOL)toRight;

#pragma mark -- 开始、拖拽中、结束拖拽

- (void)dragBeginWithPoint:(CGPoint)pt;
- (void)dragingWithPoint:(CGPoint)pt;
- (void)dragEndWithPoint:(CGPoint)pt shouldHideView:(BOOL)hideView;




@end

NS_ASSUME_NONNULL_END
