//
//  KKRefreshFooter.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/27.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKRefreshFooter.h"

@interface UIView (KKAnimation)
- (CABasicAnimation *)rotationAnimation;
- (void)stopRotationAnimation;

@end

@implementation UIView (KKAnimation)
- (CABasicAnimation *)rotationAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @0;
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    return rotationAnimation;
}
- (void)stopRotationAnimation {
    if ([self.layer animationForKey:@"rotationAnimation"]) {
        [self.layer removeAnimationForKey:@"rotationAnimation"];
    }
}

@end



@interface KKRefreshFooter()
@property (nonatomic,strong) UILabel     *titlelabel;
@property (nonatomic,strong) UIImageView *loadingImgV;

@end

@implementation KKRefreshFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    self.titlelabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.textColor     = [UIColor lightGrayColor];
        label.font          = [UIFont systemFontOfSize:11.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label;
    });
    
    self.loadingImgV = ({
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KKRefresh.bundle/loading_16x16.png"]];
        imgV.contentMode  = UIViewContentModeScaleAspectFit;
        [self addSubview:imgV];
        imgV;
    });

    self.automaticallyChangeAlpha = true;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
   self.automaticallyHidden = YES;
#pragma clang diagnostic pop
}
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.titlelabel.frame   = self.bounds;
    self.loadingImgV.bounds = CGRectMake(0, 0, 16, 16);
    self.loadingImgV.center = CGPointMake(self.mj_w * 0.5 + 60, self.mj_h * 0.5);
}
#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.titlelabel.text = @"上拉加载数据";
            self.loadingImgV.hidden = NO;
            [self.loadingImgV stopRotationAnimation];
            break;
        case MJRefreshStateRefreshing:
            self.titlelabel.text = @"正在努力加载";
            self.loadingImgV.hidden = NO;
            [self.loadingImgV rotationAnimation];
            break;
        case MJRefreshStateNoMoreData:
            self.titlelabel.text = @"人家是有底线的~😠";
            self.loadingImgV.hidden = YES;
            [self.loadingImgV stopRotationAnimation];
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
