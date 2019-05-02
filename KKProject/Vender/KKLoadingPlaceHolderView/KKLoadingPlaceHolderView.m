//
//  KKLoadingPlaceHolderView.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLoadingPlaceHolderView.h"

@interface KKLoadingPlaceHolderView ()
    
@property (nonatomic, copy) void (^callBack)(void);
@property (nonatomic, copy) void (^refreshCallBack)(void);
    
@end

@implementation KKLoadingPlaceHolderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
    
- (void)initUI {
    
    self.imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        imageView;
    });
    
    self.messageLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.layer.opacity = 0.8;
        label.text = @"Loading...";
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label;
    });
    
    UIStackView *stackView = ({
        UIStackView *view = [[UIStackView alloc] initWithArrangedSubviews:@[self.imageView,self.messageLabel]];
        view.userInteractionEnabled = NO;
        view.axis = UILayoutConstraintAxisVertical;
        view.spacing = 10;
        view.alignment = UIStackViewAlignmentCenter;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(@125);
        }];
        view;
    });
    
    self.failedButton = ({
        UIButton *button = [[UIButton alloc] init];
        button.layer.opacity = 0.8;
        [button setTitle:@"加载失败，点击重试" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#EFEFEF"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.messageLabel.mas_centerX);
            make.top.equalTo(stackView.mas_bottom).offset(10);
            make.width.mas_equalTo(self.mas_width).multipliedBy(2/3.0).offset(-20);
            make.height.mas_equalTo(44);
        }];
        button;
    });
}
    
- (void)startAnimation {
    CABasicAnimation *anmiation = [CABasicAnimation animation];
    anmiation.keyPath = @"opacity";
    anmiation.fromValue = [NSNumber numberWithFloat:1.0];
    anmiation.toValue = [NSNumber numberWithFloat:0.0];
    anmiation.duration = 1.5;
    //    anmiation.autoreverses = YES;
    anmiation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anmiation.repeatCount = INT_MAX;
    [self.messageLabel.layer addAnimation:anmiation forKey:nil];
}
    
- (void)stopAnimation {
    [self.messageLabel.layer removeAllAnimations];
}
    
- (void)setType:(KKLoadingPlaceHolderType)type {
    switch (type) {
        case KKLoadingPlaceHolderTypeLoading: {
            self.imageView.image = nil;
            self.failedButton.hidden = YES;
            self.messageLabel.text = @"loading";
            [self startAnimation];
            break;
        }
        case KKLoadingPlaceHolderTypeFailed: {
            [self stopAnimation];
            self.failedButton.hidden = NO;
            self.messageLabel.text = @"页面加载失败";
            self.imageView.image = [UIImage imageNamed:@"placeholder_sever_error"];
            break;
        }
        case KKLoadingPlaceHolderTypeBadNetwork: {
            break;
        }
        case KKLoadingPlaceHolderTypeBase: {
            
        }
        default:
        break;
    }
}
    
    
#pragma mark - Action
    
- (void)refreshAction:(UIButton *)button {
    self.type = KKLoadingPlaceHolderTypeLoading;
    [self startAnimation];
    if (self.refreshCallBack) {
        self.refreshCallBack();
    }
}
    
- (void)kk_setRefreshCB:(void(^)(void))callBack {
    self.refreshCallBack = callBack;
}
    
- (void)kk_setPlaceHolderType:(KKLoadingPlaceHolderType)type withRefreshCB:(void(^)(void))callBack {
    self.type = type;
    self.refreshCallBack = callBack;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
