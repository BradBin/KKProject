//
//  KKLoginView.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/13.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLoginView.h"
#import "KKTextField.h"

#import "KKForgetPwdViewController.h"

@interface KKLoginView ()
@property (nonatomic,strong) KKLoginViewModel *viewModel;
@property (nonatomic,strong) UIButton         *forgetBtn;
@property (nonatomic,strong) KKTextFieldView  *accounttf;
@property (nonatomic,strong) KKTextFieldView  *passwordtf;
@property (nonatomic,strong) UIButton         *loginBtn;

@end

@implementation KKLoginView

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    _viewModel = viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)kk_setupView{
    [super kk_setupView];
    
   CGFloat margin = CGFloatPixelRound(50);
    
    self.forgetBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#5B5B5B"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#9A9A9A"] forState:UIControlStateHighlighted];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.superview.mas_top);
            make.right.equalTo(button.superview.mas_right).offset(-CGFloatPixelRound(16));
            make.height.mas_equalTo(CGFloatPixelRound(44));
            make.width.mas_greaterThanOrEqualTo(@0);
        }];
        button;
    });
    
    self.passwordtf = ({
        KKTextFieldView *view = KKTextFieldView.alloc.init;
        view.textfield.placeholder = @"请输入密码...";
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.superview.mas_centerY);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width).multipliedBy(0.7);
            make.height.mas_equalTo(CGFloatPixelRound(50));
        }];
        view;
    });
    
    self.accounttf = ({
        KKTextFieldView *view = KKTextFieldView.alloc.init;
        view.textfield.placeholder = @"请输入账号...";
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.passwordtf.mas_bottom).offset(-margin * 1.25);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width).multipliedBy(0.7);
            make.height.mas_equalTo(CGFloatPixelRound(50));
        }];
        view;
    });
    
    self.loginBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageWithColor:UIColor.redColor]
                          forState:UIControlStateNormal];
        [button setTitle:@"登 录" forState:UIControlStateNormal];
        button.layer.cornerRadius = CGFloatPixelRound(8.0);
        button.layer.masksToBounds = true;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.passwordtf.mas_bottom).offset(margin * 1.5);
            make.centerX.equalTo(button.superview.mas_centerX);
            make.width.equalTo(button.superview.mas_width).multipliedBy(0.7);
            make.height.mas_equalTo(CGFloatPixelRound(50));
        }];
        button;
    });
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    RAC(self.viewModel,account)  = self.accounttf.textfield.rac_textSignal;
    RAC(self.viewModel,password) = self.passwordtf.textfield.rac_textSignal;
    self.loginBtn.rac_command    = self.viewModel.loginCommand;
    @weakify(self);
    [[self.forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        KKForgetPwdViewController *vc = KKForgetPwdViewController.new;
        [self.viewModel.pushVCSubject sendNext:vc];
    }];
    
    [self.viewModel.loginCommand.executing subscribeNext:^(NSNumber * _Nullable x) {
   
        
    }];
    
    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.viewModel.pushVCSubject sendNext:@(true)];
    }];
    
    [self.viewModel.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
        if ([x isKindOfClass:KKError.class]) {
            [UIView showTitle:[(KKError *)x desc]];
        }
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
