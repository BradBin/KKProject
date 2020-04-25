//
//  KKTidingView.m
//  KKProject
//
//  Created by youbin on 2020/4/23.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTidingView.h"

@interface KKTidingView()<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>

@property (nonatomic, strong) KKTidingViewModel *viewModel;
@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) UIButton *stateButton;

@property (nonatomic, strong) YYAnimatedImageView *backImageView;
@property (nonatomic, strong) UIButton *refreshButton;

@end

@implementation KKTidingView

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    _viewModel = viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)kk_setupView{
    [super kk_setupView];
    
    self.backScrollView = ({
        UIScrollView *view = UIScrollView.alloc.init;
        view.delegate = self;
        
        view.directionalLockEnabled = true;//设置是否只允许同时滚动一个方向
        /// UIScrollViewDecelerationRateNormal: 默认, 慢慢停止,UIScrollViewDecelerationRateFast: 快速停止
        view.decelerationRate = UIScrollViewDecelerationRateNormal;
        
        ///滚动条的样式
        view.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.bottom.equalTo(view.superview.mas_bottom);
        }];
        view;
    });
    
    self.stateButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.randomColor;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(button.superview.mas_right);
            make.bottom.equalTo(button.superview.mas_bottom).offset(-100);
            make.size.mas_equalTo(CGSizeMake(60, 45));
        }];
        button;
    });
    
    self.backImageView = ({
        YYAnimatedImageView *view = YYAnimatedImageView.new;
        view.clipsToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFit;
        [self.backScrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top).offset(60);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
        }];
        view;
    });
   
    self.refreshButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [self.backScrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backImageView.mas_bottom).offset(100);
            make.centerX.equalTo(button.superview.mas_centerX);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(80);
        }];
        button;
    });
    
    [self.backScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.refreshButton.mas_bottom).offset(1000);
    }];
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    
    [[self.stateButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"关注");
    }];
    
    [self.backImageView setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587669398565&di=f6399ad0f083db10caaff4d80ec1e0fb&imgtype=0&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3547950840%2C3781297357%26fm%3D214%26gp%3D0.jpg"] options:YYWebImageOptionProgressiveBlur];
}


#pragma mark -UIScrollViewDelegate
/// 滚动时执行的方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"滚动时执行的方法");
}

/// 滚动--即将开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"滚动--即将开始拖拽");
    [UIView animateWithDuration:0.25 animations:^{
        self.stateButton.transform = CGAffineTransformMakeTranslation(50, 0);
    }];
}

/// 滚动--即将停止拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"滚动--即将停止拖拽: %@  %@",NSStringFromCGPoint(velocity),NSStringFromCGPoint(*targetContentOffset));
}
   
/// 滚动--停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     NSLog(@"滚动--停止拖拽: %@",@(decelerate));
    
    if (decelerate) return;
    [UIView animateWithDuration:0.25 animations:^{
           self.stateButton.transform = CGAffineTransformIdentity;
       }];
}

/// 即将滚动结束
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"即将滚动结束");
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     NSLog(@"滚动结束");
    [UIView animateWithDuration:0.25 animations:^{
        self.stateButton.transform = CGAffineTransformIdentity;
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
