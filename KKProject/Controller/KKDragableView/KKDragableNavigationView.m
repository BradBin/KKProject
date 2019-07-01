//
//  KKDragableNavigationView.m
//  KKProject
//
//  Created by 尤彬 on 2019/7/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDragableNavigationView.h"

@implementation KKDragableNavigationView


-(void)viewWillAppear{
    [super viewWillAppear];

}

-(void)viewDidAppear{
    [super viewDidAppear];
}

-(void)viewWillDisappear{
    [super viewWillDisappear];
}

-(void)viewDidDisappear{
    [super viewDidDisappear];
}



- (void)setupView{
    [super setupView];
    self.navigationBar = ({
        KKDragableHeaderView *view = KKDragableHeaderView.alloc.init;
        view.backgroundColor = [UIColor lightTextColor];
        [self.dragContentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(88);
        }];
        view;
    });
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end








@interface KKDragableHeaderView()
@property (nonatomic,strong) UIView *navigationBarView;
@property (nonatomic,strong) UILabel *titleLabel;

@end


@implementation KKDragableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.bottomLineView = ({
        YYAnimatedImageView *view = YYAnimatedImageView.alloc.init;
        view.backgroundColor = [UIColor colorWithHexString:@"#BBBFC5"];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view.superview.mas_bottom);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(CGFloatPixelRound(0.5));
        }];
        view;
    });
    
    self.navigationBarView = ({
        UIView *view = UIView.alloc.init;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottomLineView.mas_top);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(CGFloatPixelRound(44.0f));
        }];
        view;
    });
    
    self.leftButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.navigationBarView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.superview.mas_left).offset(CGFloatPixelRound(12));
            make.centerY.equalTo(button.superview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(CGFloatPixelRound(44.0f), CGFloatPixelRound(44.0f)));
        }];
        button;
    });
    
    self.rightButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.navigationBarView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(button.superview.mas_right).offset(-CGFloatPixelRound(12));
            make.centerY.equalTo(button.superview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(CGFloatPixelRound(44.0f), CGFloatPixelRound(44.0f)));
        }];
        button;
    });
    
    self.titleView = ({
        UIView *view = UIView.alloc.init;
        [self.navigationBarView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.superview.mas_centerY);
            make.height.equalTo(view.superview.mas_height);
            make.left.equalTo(self.leftButton.mas_right);
            make.right.equalTo(self.rightButton.mas_left).priorityLow();
        }];
        view;
    });
    
    self.titleLabel = ({
        UILabel *label = UILabel.new;
        label.textAlignment = NSTextAlignmentCenter;
        [self.navigationBarView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label.superview.mas_centerY);
            make.height.equalTo(label.superview.mas_height);
            make.left.equalTo(self.leftButton.mas_right);
            make.right.equalTo(self.rightButton.mas_left).priorityLow();
        }];
        label;
    });
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

@end
