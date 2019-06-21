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
    return (safeEdgeInsets().top + CGFloatPixelRound(screenSize().width));
}

static inline CGFloat channelHeight(){
    return (screenSize().height - channelTopMargin());
}

static inline CGFloat headHeight(){
    return CGFloatPixelRound(50);
}

static CGFloat const channelDuration = 0.3;
static NSInteger channelCount        = 0;
@interface KKChannelView()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) YYTimer       *hideTimer;
@property (nonatomic,  copy) KKChannelBlock hideBlock;

@end

@implementation KKChannelView

- (void)dealloc{
    NSLog(@"KKChannelView dealloc");
    channelCount = 0;
    if (self.hideTimer) {
        if (self.hideTimer.valid) {
            [self.hideTimer invalidate];
        }
        self.hideTimer = nil;
    }
    [NSNotificationCenter.defaultCenter removeObserver:self];
}



- (instancetype)kk_updateConfigure:(void (^)(KKChannelView * _Nonnull))block{
    if (block) block(self);
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.contentView ]) {
        return  false;
    }
    return true;
}

+ (instancetype)kk_channelViewWithViewModel:(id<KKViewModelProtocol>)viewModel{
    return [[self alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    self = [super initWithViewModel:viewModel];
    self.frame = CGRectMake(0, 0, screenSize().width, screenSize().height);
    [self kk_addNotificationObserver];
    return self;
}

/**
 添加观察者
 */
- (void)kk_addNotificationObserver{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(kk_appDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(kk_appDidBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)kk_setupView{
    [super kk_setupView];
    self.showDuration = ULONG_LONG_MAX;
    
    //    self.hideTimer = ({
    //        //立即执行定时任务,间隔1秒执行一次
    //        YYTimer *timer = [YYTimer timerWithTimeInterval:1.0 target:self selector:@selector(kk_hideEvent:) repeats:true];
    //        [timer fire];
    //        timer;
    //    });
    
    self.hideTimer = ({
        NSLog(@"-----YYTimer-------");
        //比当前晚多长(0.5秒)时间开始执行定时器任务,间隔1秒执行一次
        YYTimer *timer = [[YYTimer alloc] initWithFireTime:0.5 interval:1.0 target:self selector:@selector(kk_hideEvent:) repeats:true];
        timer;
    });
    
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
    
    self.titlelabel = ({
        YYLabel *label = YYLabel.alloc.init;
        label.numberOfLines   = 1;
        label.textAlignment   = NSTextAlignmentCenter;
        label.text            = @"Title";
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.superview.mas_top);
            make.centerX.equalTo(label.superview.mas_centerX);
            make.left.equalTo(label.superview.mas_left).offset(headHeight());
            make.right.equalTo(label.superview.mas_right).offset(-headHeight());
            make.height.mas_greaterThanOrEqualTo(CGFloatPixelRound(44));
            make.height.mas_lessThanOrEqualTo(CGFloatPixelRound(80));
        }];
        label;
    });
    
    self.closeBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"home_down.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.superview.mas_top);
            make.right.equalTo(button.superview.mas_right);
            make.width.height.mas_equalTo(headHeight());
        }];
        button;
    });
}

-(void)setShowDuration:(NSUInteger)showDuration{
    if (showDuration >= 3) {
        _showDuration = showDuration;
    }else{
        _showDuration = 3;
        NSLog(@"KKChannelView : The Minimum effective time is 3S,Please modify \"showDuration\"");
    }
    
}

- (void)kk_hideEvent:(YYTimer *)timer{
    if (channelCount < _showDuration) {
        channelCount ++;
        NSLog(@"KKChannelView YYTimer ---- %ld",(long)channelCount);
    }else{
        channelCount = 0;
        [timer invalidate];
        [self kk_hideBlock:self.hideBlock];
    }
}

- (void)kk_bindViewModel{
    [super kk_bindViewModel];
    @weakify(self);
    UITapGestureRecognizer *tapGestrue = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self kk_hideBlock];
    }];
    tapGestrue.delegate = self;
    [self addGestureRecognizer:tapGestrue];
    
    [[self.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self kk_hideBlock];
    }];
}

- (void)kk_showBlock:(KKChannelBlock)showBlock hideBlock:(KKChannelBlock)hideBlock{
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    
    UIImage *backImg = [UIImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.01] size:self.bounds.size];
    backImg          = [backImg imageByBlurRadius:10 tintColor:[UIColor colorWithWhite:1.0 alpha:0.1] tintMode:kCGBlendModeNormal saturation:1.0 maskImage:nil];
    
    self.layer.contents    = (id)backImg.CGImage;
    self.layer.contentMode = UIViewContentModeScaleAspectFit;
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:channelDuration delay:0.0 usingSpringWithDamping:5 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.superview.mas_bottom).offset(-channelHeight());
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (showBlock) showBlock();
    }];
    self.hideBlock = hideBlock;
}

- (void)kk_hideBlock{
    [self kk_hideBlock:self.hideBlock];
}

- (void)kk_hideBlock:(KKChannelBlock)hideBlock{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.superview.mas_bottom);
    }];
    [UIView animateWithDuration:channelDuration animations:^{
        self.backgroundColor = UIColor.clearColor;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (hideBlock) hideBlock();
    }];
}

#pragma mark -
#pragma mark - 观察者事件响应
- (void)kk_appDidEnterBackgroundNotification{
    NSLog(@"kk_appDidEnterBackgroundNotification");
    if (self.hideTimer) {
        if (self.hideTimer.valid) {
            [self.hideTimer invalidate];
        }
    }
}

- (void)kk_appDidBecomeActiveNotification{
    NSLog(@"kk_appDidBecomeActiveNotification");
    self.hideTimer = nil;
    self.hideTimer = [[YYTimer alloc] initWithFireTime:0.1 interval:1.0 target:self selector:@selector(kk_hideEvent:) repeats:true];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
