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
        UIView *view = UIView.alloc.init;
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
