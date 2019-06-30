//
//  KKDragableView.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/29.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDragableView.h"
#import "KKImageZoomView.h"
#import "UIView+KKGestureRecognizer.h"

CGFloat const gestureMinimumTranslation = 5.0;
CGFloat const kkDuration = 0.3f;//动画持续时长
@interface KKDragableView()<UIGestureRecognizerDelegate,CAAnimationDelegate>
@property(nonatomic,strong) UIView *dragViewBg ;//用户设置整个视图的背景
@property(nonatomic,strong) UIView *dragContentView ;//需要显示的视图都加到contentView里面
@property(nonatomic,strong) UIPanGestureRecognizer *panRecognizer;//拖动视图的手势
@property(nonatomic,assign) KKMoveDirection dragDirection;//拖动的方向

@end

@implementation KKDragableView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initDragableBaseView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.dragContentView.frame = CGRectMake(0, self.topSpace,self.width, self.height - self.topSpace);
}

- (void)dealloc{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)initDragableBaseView{
    self.topSpace = 0;
    self.contentViewCornerRadius = 0 ;
    self.cornerEdge = UIRectCornerAllCorners;
    self.enableHorizonDrag = YES ;
    self.enableVerticalDrag = YES ;
    self.enableFreedomDrag = NO ;
    self.defaultHideAnimateWhenDragFreedom = YES ;
    [self addGestureRecognizer:self.panRecognizer];
    [self addSubview:self.dragViewBg];
    [self addSubview:self.dragContentView];
    
    self.dragContentView.frame = CGRectMake(0, self.topSpace,self.width, self.height - self.topSpace);
    
    [self.dragViewBg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    @weakify(self);
    [self.dragViewBg addTapGestureWithBlock:^(UIView *gestureView) {
        @strongify(self);
        [self startHide];
    }];
}

#pragma mark -- 拖动手势

- (void)panRecognizer:(UIPanGestureRecognizer *)panRecognizer{
    UIGestureRecognizerState state = panRecognizer.state;
    CGPoint point = [panRecognizer translationInView:self];
    if(state == UIGestureRecognizerStateChanged){
        if(self.enableFreedomDrag){
            //如果self.direction == KKMoveDirectionNone，说明偏移量还没有达到gestureMinimumTranslation，不允许拖动
            if(self.dragDirection == KKMoveDirectionNone){
                self.dragDirection = [self determineDirection:point];
                return ;
            }
            CGFloat top = fabs(self.dragContentView.top);
            CGFloat left = fabs(self.dragContentView.left);
            self.dragContentView.centerY = self.dragContentView.centerY + point.y;
            self.dragContentView.centerX = self.dragContentView.centerX + point.x;
            CGFloat alphaTop = (1.0 - (top - self.topSpace) / self.dragContentView.height) ;
            CGFloat alphaLeft = (1.0 - left / self.dragContentView.width) ;
            self.dragViewBg.alpha = MAX(MIN(alphaTop,alphaLeft),0);
            
            [panRecognizer setTranslation:CGPointMake(0, 0) inView:self];
            
            [self dragingWithPoint:[panRecognizer locationInView:self]];
            
        }else{
            if(self.dragDirection == KKMoveDirectionNone){
                self.dragDirection = [self determineDirection:point];
            }
            if(self.dragDirection == KKMoveDirectionUp ||
               self.dragDirection == KKMoveDirectionDown){
                if(!self.enableVerticalDrag){
                    self.dragDirection = KKMoveDirectionNone ;
                    self.dragViewBg.alpha = 1.0 ;
                    self.dragContentView.top = self.topSpace;
                    self.dragContentView.layer.transform = CATransform3DIdentity;
                    return ;
                }
                CGFloat top = self.dragContentView.top;
                if(top + point.y < self.topSpace){
                    self.dragContentView.top = self.topSpace ;
                    return ;
                }
                self.dragContentView.centerY = self.dragContentView.centerY + point.y;
                CGFloat alpha = (1.0 - (top - self.topSpace) / self.dragContentView.height) ;
                self.dragViewBg.alpha = MAX(alpha,0);
                
                [panRecognizer setTranslation:CGPointMake(0, 0) inView:self];
                
                [self dragingWithPoint:[panRecognizer locationInView:self]];
                
            }else if(self.dragDirection == KKMoveDirectionLeft ||
                     self.dragDirection == KKMoveDirectionRight){
                if(!self.enableHorizonDrag){
                    self.dragDirection = KKMoveDirectionNone ;
                    self.dragViewBg.alpha = 1.0 ;
                    self.dragContentView.left = 0;
                    self.dragContentView.layer.transform = CATransform3DIdentity;
                    return ;
                }
                CGFloat left = self.dragContentView.left;
                self.dragContentView.centerX = self.dragContentView.centerX + point.x;
                CGFloat alpha = (1.0 - left / self.dragContentView.width) ;
                self.dragViewBg.alpha = MAX(alpha,0);
                
                [panRecognizer setTranslation:CGPointMake(0, 0) inView:self];
                
                [self dragingWithPoint:[panRecognizer locationInView:self]];
            }
        }
    }else if(state == UIGestureRecognizerStateEnded ||
             state == UIGestureRecognizerStateFailed ||
             state == UIGestureRecognizerStateCancelled){
        BOOL shouldHideView = NO ;
        CGFloat top = self.dragContentView.top;
        CGFloat left = self.dragContentView.left;
        CGFloat maxOffsetY = self.dragContentView.height / 6 ;
        CGFloat maxOffsetX = self.dragContentView.width / 6 ;
        if(self.enableFreedomDrag){
            if(((top - self.topSpace) >= maxOffsetY) ||
               (top < 0 && (fabs(top) - self.topSpace) >= maxOffsetY)){
                if(self.defaultHideAnimateWhenDragFreedom){
                    [self popOutToTop:top < 0];
                    return ;
                }
                shouldHideView = YES ;
            }else{
                if(left >= maxOffsetX ||
                   (left < 0 && fabs(left) >= maxOffsetX)){
                    if(self.defaultHideAnimateWhenDragFreedom){
                        [self pushOutToRight:left > 0];
                        return ;
                    }
                    shouldHideView = YES ;
                }else{
                    [self restoreView];
                }
            }
        }else{
            if(self.dragDirection == KKMoveDirectionUp ||
               self.dragDirection == KKMoveDirectionDown){
                if((top-self.topSpace) >= maxOffsetY){
                    [self popOutToTop:NO];
                    shouldHideView = YES ;
                }else{
                    [self restoreView];
                }
            }else if(self.dragDirection == KKMoveDirectionLeft ||
                     self.dragDirection == KKMoveDirectionRight){
                CGFloat left = self.dragContentView.left;
                if(left > 0 && left >= maxOffsetX){
                    [self pushOutToRight:YES];
                    shouldHideView = YES ;
                }else if(left < 0 && fabs(left) >= maxOffsetX){
                    [self pushOutToRight:NO];
                    shouldHideView = YES ;
                }else{
                    [self restoreView];
                }
            }
        }
        
        [self dragEndWithPoint:[panRecognizer locationInView:self] shouldHideView:shouldHideView];
        
    }else if(state == UIGestureRecognizerStateBegan){
        self.dragDirection = KKMoveDirectionNone;
        [self dragBeginWithPoint:[panRecognizer locationInView:self]];
    }
}

- (KKMoveDirection)determineDirection:(CGPoint)translation{
    if (self.dragDirection != KKMoveDirectionNone){
        return self.dragDirection;
    }
    if (fabs(translation.x) > gestureMinimumTranslation){
        BOOL gestureHorizontal = NO;
        if (translation.y ==0.0){
            gestureHorizontal = YES;
        }else{
            gestureHorizontal = fabs(translation.x - translation.y) > gestureMinimumTranslation;
        }
        if (gestureHorizontal){
            if (translation.x >0.0){
                return KKMoveDirectionRight;
            }else{
                return KKMoveDirectionLeft;
            }
        }
    }else if (fabs(translation.y) > gestureMinimumTranslation){
        BOOL gestureVertical = NO;
        if (translation.x ==0.0){
            gestureVertical = YES;
        }else{
            gestureVertical = fabs(translation.x - translation.y) >gestureMinimumTranslation;
        }
        if (gestureVertical){
            if (translation.y >0.0){
                return KKMoveDirectionDown;
            }else{
                return KKMoveDirectionUp;
            }
        }
    }
    return self.dragDirection;
}

#pragma mark -- 恢复视图的正确位置

- (void)restoreView{
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:2.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.dragViewBg.alpha = 1.0 ;
                         self.dragContentView.left = 0;
                         self.dragContentView.top = self.topSpace;
                         self.dragContentView.layer.transform = CATransform3DIdentity;
                     }completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark -- 显示与隐藏动画

- (void)startShow{
    
    [self viewWillAppear];
    self.showViewType = KKShowViewTypeNone;
    self.dragViewBg.alpha = 0 ;
    self.dragContentView.top = KKScreenHeight();
    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.85
          initialSpringVelocity:5.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.dragViewBg.alpha = 1.0 ;
                         self.dragContentView.top = self.topSpace;
                     }completion:^(BOOL finished) {
                         [self viewDidAppear];
                     }];
}

- (void)startHide{
    [self viewWillDisappear];
    [UIView animateWithDuration:0.2 animations:^{
        self.dragViewBg.alpha = 0.0 ;
        self.dragContentView.top = KKScreenHeight();
    } completion:^(BOOL finished) {
        [self removeGestureRecognizer:self.panRecognizer];
        [self viewDidDisappear];
        [self removeFromSuperview];
    }];
}

- (void)popIn{
    [self viewWillAppear];
    self.showViewType = KKShowViewTypePopup;
    self.dragContentView.top = KKScreenHeight();
    self.dragViewBg.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.dragContentView.top = self.topSpace ;
        self.dragViewBg.alpha = 1.0;
    }completion:^(BOOL finished) {
        [self viewDidAppear];
    }];
}

- (void)popOutToTop:(BOOL)toTop{
    [self viewWillDisappear];
    [UIView animateWithDuration:0.3 animations:^{
        if(toTop){
            self.dragContentView.top = -KKScreenHeight() ;
        }else{
            self.dragContentView.top = KKScreenHeight() ;
        }
        self.dragViewBg.alpha = 0.0 ;
    }completion:^(BOOL finished) {
        [self viewDidDisappear];
        [self removeFromSuperview];
    }];
}



- (void)pushViewWithAnimated:(BOOL)animated{
    [self viewWillAppear];
    self.showViewType = KKShowViewTypePush;
    self.dragContentView.left = KKScreenWidth() ;
    self.dragViewBg.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.dragContentView.left = 0 ;
        self.dragViewBg.alpha = 1.0;
    }completion:^(BOOL finished) {
        [self viewDidAppear];
    }];
}

- (void)pushOutToRight:(BOOL)toRight{
    [self viewWillDisappear];
    [UIView animateWithDuration:0.3 animations:^{
        if(toRight){
            self.dragContentView.left = KKScreenWidth() ;
        }else{
            self.dragContentView.left = -KKScreenWidth() ;
        }
        self.dragViewBg.alpha = 0.0 ;
    }completion:^(BOOL finished) {
        [self viewDidDisappear];
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    UIView *view = otherGestureRecognizer.view ;
    //与KKImageZoomView的点击、双击手势冲突
    if([view isKindOfClass:[KKImageZoomView class]] &&
       [otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]){
        return NO ;
    }else{
        //与上下滚动的视图有冲突
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *view = (UIScrollView *)otherGestureRecognizer.view;
            if(view.contentOffset.y > 0.0){
                return NO ;
            }
            if(view.tag == KKViewTagPersonInfoArtical ||
               view.tag == KKViewTagPersonInfoVideo ||
               view.tag == KKViewTagPersonInfoWenDa ||
               view.tag == KKViewTagPersonInfoDongTai ||
               view.tag == KKViewTagPersonInfoScrollView ||
               view.tag == KKViewTagRecognizeSimultaneousTableView ||
               view.tag == KKViewTagUserCenterView ||
               view.tag == KKViewTagPersonInfoRelease ||
               view.tag == KKViewTagPersonInfoMatrix ||
               view.tag == KKViewTagImageDetailView ||
               view.tag == KKViewTagImageDetailDescView){
                return NO ;
            }
            return YES;
        }
    }
    
    return NO;
}

#pragma mark -- 开始、结束拖拽

- (void)dragBeginWithPoint:(CGPoint)pt{
    
}

- (void)dragingWithPoint:(CGPoint)pt{
    
}

- (void)dragEndWithPoint:(CGPoint)pt shouldHideView:(BOOL)hideView{
    
}

#pragma mark -- 视图显示/消失

- (void)viewWillAppear{
    
}

- (void)viewDidAppear{
    
}

- (void)viewWillDisappear{
    
}

- (void)viewDidDisappear{
    
}

#pragma mark -- 设置圆角

- (void)adjustCornerRadius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KKScreenWidth(), KKScreenHeight()) byRoundingCorners:self.cornerEdge cornerRadii:CGSizeMake(self.contentViewCornerRadius, self.contentViewCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, KKScreenWidth(), KKScreenHeight());
    maskLayer.path = maskPath.CGPath;
    self.dragContentView.layer.mask = maskLayer;
}

#pragma mark -- @property setter

- (void)setContentViewCornerRadius:(CGFloat)contentViewCornerRadius{
    _contentViewCornerRadius = contentViewCornerRadius;
    [self adjustCornerRadius];
}

- (void)setCornerEdge:(UIRectCorner)cornerEdge{
    _cornerEdge = cornerEdge;
    [self adjustCornerRadius];
}

#pragma mark -- @property getter

- (UIView *)dragViewBg{
    if(!_dragViewBg){
        _dragViewBg = ({
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            view ;
        });
    }
    return _dragViewBg;
}

- (UIView *)dragContentView{
    if(!_dragContentView){
        _dragContentView = ({
            UIView *view = [[UIView alloc]init];
            view.clipsToBounds = YES ;
            view.backgroundColor = [UIColor whiteColor];
            view ;
        });
    }
    return _dragContentView;
}

- (UIPanGestureRecognizer *)panRecognizer{
    if(!_panRecognizer){
        _panRecognizer = ({
            UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognizer:)];
            recognizer.delegate = self ;
            recognizer;
        });
    }
    return _panRecognizer;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
