//
//  KKURLSessionView_offlineDown.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/19.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKURLSessionView_offlineDown.h"


@interface KKURLSessionView_offlineDown ()<NSURLSessionDataDelegate>

@property (nonatomic, strong) UIButton   *button;
@property (nonatomic, strong) UIButton   *cancelButton;
@property (nonatomic, strong) UITextView *textView;


@end

@implementation KKURLSessionView_offlineDown


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self bindViewModel];
    }
    return self;
}

- (void)setupView{
    
    self.button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"文件上传请求/开始" forState:UIControlStateNormal];
        [button setTitle:@"文件上传请求/暂停" forState:UIControlStateSelected];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.superview).offset(50).priorityMedium();
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        button;
    });
    
    self.cancelButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"文件上传请求/取消" forState:UIControlStateNormal];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.button.mas_bottom).offset(50);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        button;
    });
    
    self.textView = ({
        UITextView *view = UITextView.new;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cancelButton.mas_bottom).offset(40);
            make.centerX.equalTo(view.superview);
            make.width.equalTo(view.superview).multipliedBy(0.85);
            make.bottom.equalTo(view.superview.mas_bottom).offset(-40);
        }];
        view;
    });
    
    
    @weakify(self);
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        x.selected = !x.selected;
        if (x.selected) {
           
        }else{
          
        }
    }];
    
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
    }];
    
}

-(void)bindViewModel{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
