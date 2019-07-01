//
//  KKShareView.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/21.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKShareView.h"
#import "KKShareConst.h"
#import "KKShareCollectionView.h"


static CGFloat const shareDuration = 0.3;
@interface KKShareView ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic,  copy) KKShareBlock hideBlock;
@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) NSArray *functions;

@property (nonatomic,strong) UIView   *containerView;
@property (nonatomic,strong) UIView   *contentView;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIView   *titleView;
@property (nonatomic,strong) KKShareCollectionView *itemsView;
@property (nonatomic,strong) KKShareCollectionView *functionsView;

@end

@implementation KKShareView

- (void)dealloc{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self kk_setupView];
        [self kk_bindViewModel];
    }
    return self;
}

+ (instancetype)shared{
    static KKShareView *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
        _instance.frame = CGRectMake(0, 0, screenSize().width, screenSize().height);
    });
    return _instance;
}


- (instancetype)kk_updateConfigure:(void (^)(KKShareView * _Nonnull))block{
    if (block) {
        block(self);
    }
    return self;
}

- (void)kk_setupView{

    self.containerView = ({
        UIView *view = UIView.alloc.init;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_bottom);
            make.left.equalTo(view.superview.mas_left).offset(margin());
            make.right.equalTo(view.superview.mas_right).offset(-margin());
            make.height.mas_equalTo(shareHeight());
        }];
        view;
    });
    
    self.cancelBtn = ({
        UIButton *button           = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.masksToBounds = true;
        button.layer.cornerRadius  = margin();
        button.backgroundColor     = [UIColor colorWithWhite:1.0 alpha:1.0];
        button.titleLabel.font     = [UIFont systemFontOfSize:15.0];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.1 alpha:0.85] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(kk_hide) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(button.superview.mas_bottom);
            make.centerX.equalTo(button.superview.mas_centerX);
            make.width.equalTo(button.superview.mas_width);
            make.height.mas_equalTo(cancelHeight());
        }];
        button;
    });
    
    self.contentView = ({
        UIView *view             = UIView.alloc.init;
        view.layer.masksToBounds = true;
        view.layer.cornerRadius  = margin();
        view.backgroundColor     = [UIColor colorWithWhite:1.0 alpha:1.0];
        [self.containerView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top).offset(margin());
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.bottom.equalTo(self.cancelBtn.mas_top).offset(-marginV());
        }];
        view;
    });
    
    self.titleView = ({
        UIView *view = UIView.alloc.init;
        view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(titleHeight());
        }];
        view;
    });
    
    self.itemsView = ({
        KKShareCollectionView *view = KKShareCollectionView.alloc.init;
        view.hidden = true;
        [self.contentView addSubview:view];
        view;
    });
    
    self.functionsView = ({
        KKShareCollectionView *view = KKShareCollectionView.alloc.init;
        view.hidden = true;
        [self.contentView addSubview:view];
        view;
    });
    
}

- (void)kk_bindViewModel{
    self.tapGesture = ({
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kk_hide)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        tapGesture;
    });
}

-(instancetype)kk_shareWithItems:(NSArray *)items functions:(NSArray *)functions showBlock:(KKShareBlock)showBlock hideBlock:(KKShareBlock)hideBlock{
    
    [UIApplication.sharedApplication.keyWindow addSubview:self];
  
    self.hideBlock = hideBlock;
    self.items     = [items copy];
    self.functions = [functions copy];
    CGFloat contentHeight = [self kk_updateContentViewframeWithItems:items functions:functions];
   
    [self layoutIfNeeded];
    [UIView animateWithDuration:shareDuration delay:0.05 usingSpringWithDamping:5 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.1];
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.containerView.superview.mas_bottom).offset(-(contentHeight + safeEdgeInsets().bottom + margin()));
            make.height.mas_equalTo(contentHeight);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (showBlock) {
            showBlock();
        }
    }];
    return self;
}

- (CGFloat )kk_updateContentViewframeWithItems:(NSArray *)items functions:(NSArray *)functions{
    NSInteger rows = 0;
    if (self.items.count && self.functions.count) {
        rows = 2;
        self.itemsView.hidden     = false;
        self.functionsView.hidden = false;
        [self.itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom);
            make.centerX.equalTo(self.itemsView.superview.mas_centerX);
            make.width.equalTo(self.itemsView.superview.mas_width);
        }];
        [self.functionsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.itemsView.mas_bottom);
            make.centerX.equalTo(self.functionsView.superview.mas_centerX);
            make.width.equalTo(self.functionsView.superview.mas_width);
            make.bottom.equalTo(self.functionsView.superview.mas_bottom).offset(-margin());
            make.height.equalTo(self.itemsView.mas_height);
        }];
    }else if(self.items.count && !self.functions.count){
        rows = 1;
        self.itemsView.hidden     = false;
        self.functionsView.hidden = true;
        [self.itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom);
            make.centerX.equalTo(self.itemsView.superview.mas_centerX);
            make.width.equalTo(self.itemsView.superview.mas_width);
            make.bottom.equalTo(self.itemsView.superview.mas_bottom).offset(-margin());
        }];
        
    }else if (!self.items.count && self.functions.count){
        rows = 1;
        self.itemsView.hidden      = true;
        self.functionsView.hidden = false;
        [self.functionsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom);
            make.centerX.equalTo(self.functionsView.superview.mas_centerX);
            make.width.equalTo(self.functionsView.superview.mas_width);
            make.bottom.equalTo(self.functionsView.superview.mas_bottom).offset(-margin());
        }];
    }else{
        rows = 0;
        self.itemsView.hidden     = true;
        self.functionsView.hidden = true;
    }
    return  titleHeight() + collectionHeight() * rows + cancelHeight() + marginV();
}

- (void)kk_hideBlock:(KKShareBlock)hideBlock{
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.superview.mas_bottom);
    }];
    [UIView animateWithDuration:shareDuration animations:^{
        self.backgroundColor = UIColor.clearColor;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (hideBlock) hideBlock();
    }];
}

- (void)kk_hide{
    [self kk_hideBlock:self.hideBlock];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.containerView]) {
        return false;
    }
    return true;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
