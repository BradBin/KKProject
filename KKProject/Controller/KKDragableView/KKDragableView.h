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

@property(nonatomic,strong,readonly) UIView *dragViewBg ;//用户设置整个视图的背景
@property(nonatomic,strong,readonly) UIView *dragContentView ;//需要显示的视图都加到dragContentView里面

@property(nonatomic,assign) CGFloat topSpace ;//dragContentView的顶部距离屏幕上方的距离
@property(nonatomic,assign) CGFloat contentViewCornerRadius;//dragContentView的圆角
@property(nonatomic,assign) UIRectCorner cornerEdge;//设定dragContentView的哪些边需要圆角
@property(nonatomic,assign,readonly) KKMoveDirection dragDirection;//拖动的方向
@property(nonatomic,assign) BOOL enableHorizonDrag;//是否允许水平拖拽，默认为YES
@property(nonatomic,assign) BOOL enableVerticalDrag;//是否允许垂直拖拽，默认为YES
@property(nonatomic,assign) BOOL enableFreedomDrag;//允许自由拖拽,默认为NO,设为YES，则enableHorizonDrag、enableVerticalDrag自动失效
@property(nonatomic,assign) BOOL defaultHideAnimateWhenDragFreedom;//自由拖拽时，是否使用默认的隐藏动画，默认为YES
@property(nonatomic,assign) KKShowViewType showViewType;//pop push


#pragma mark -- 视图显示/消失

- (void)viewWillAppear;
- (void)viewDidAppear;
- (void)viewWillDisappear;
- (void)viewDidDisappear;

#pragma mark -- 显示与隐藏动画

- (void)startShow;
- (void)startHide;

- (void)popIn;
- (void)popOutToTop:(BOOL)toTop;
- (void)pushViewWithAnimated:(BOOL)animated;
- (void)pushOutToRight:(BOOL)toRight;

#pragma mark -- 开始、拖拽中、结束拖拽

- (void)dragBeginWithPoint:(CGPoint)pt;
- (void)dragingWithPoint:(CGPoint)pt;
- (void)dragEndWithPoint:(CGPoint)pt shouldHideView:(BOOL)hideView;




@end

NS_ASSUME_NONNULL_END
