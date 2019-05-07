//
//  KKChannelView.m
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKChannelView.h"

static inline CGSize screenSize(){
    return UIScreen.mainScreen.bounds.size;
}
static inline UIEdgeInsets safeEdgeInsets(){
    UIEdgeInsets safeInsets = UIEdgeInsetsZero;
    if (@available(iOS 11, *)) {
        safeInsets = UIApplication.sharedApplication.keyWindow.safeAreaInsets;
    }
    return safeInsets;
}
static inline CGFloat channelTopMargin(){
    return (safeEdgeInsets().top + 50);
}
static inline CGFloat channelHeight(){
    return (screenSize().height - channelTopMargin());
}

static CGFloat const duration = 0.3;
@interface KKChannelView()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView        *contentView;
@property (nonatomic,  copy) KKChannelBlock hideBlock;

@end

@implementation KKChannelView

-(void)dealloc{
    NSLog(@"KKChannelView dealloc");
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.contentView ]) {
        return  false;
    }
    return true;
}

+(instancetype)kk_channelViewWithViewModel:(id<KKViewModelProtocol>)viewModel{
    return [[self alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    self = [super initWithViewModel:viewModel];
    self.frame = CGRectMake(0, 0, screenSize().width, screenSize().height);
    return self;
}

-(void)kk_setupView{
    [super kk_setupView];
    self.backgroundColor = [UIColor colorWithWhite:0.05 alpha:0.05];
    self.contentView = ({
        UIView *view             = UIView.alloc.init;
        view.layer.masksToBounds = true;
        view.layer.cornerRadius  = 5.0f;
        view.backgroundColor     = UIColor.whiteColor;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_bottom);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(channelHeight());
        }];
        view;
    });
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    @weakify(self);
    UITapGestureRecognizer *tapGestrue = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self kk_hideBlock];
    }];
    tapGestrue.delegate = self;
    [self addGestureRecognizer:tapGestrue];
}

-(void)kk_showBlock:(KKChannelBlock)showBlock hideBlock:(KKChannelBlock)hideBlock{
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    [self layoutIfNeeded];
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.superview.mas_bottom).offset(-channelHeight());
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (showBlock) showBlock();
    }];
    self.hideBlock = hideBlock;
}

- (void) kk_hideBlock{
    [self kk_hideBlock:self.hideBlock];
}

- (void) kk_hideBlock:(KKChannelBlock)hideBlock{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.superview.mas_bottom);
    }];
    [UIView animateWithDuration:duration animations:^{
        self.backgroundColor = UIColor.clearColor;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (hideBlock) hideBlock();
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
