//
//  KKEventView.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/8.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKEventView.h"

@implementation KKEventView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.eventSubView = ({
        UIView *view = UIView.new;
        view.backgroundColor = UIColor.redColor;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.superview);
            make.centerY.equalTo(view.superview);
            make.width.equalTo(view.superview).multipliedBy(0.5);
            make.height.equalTo(view.superview).multipliedBy(0.5);
        }];
        view;
    });
    
    self.roundButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor    = UIColor.redColor;
        button.layer.masksToBounds = true;
        button.clipsToBounds       = true;
        button.layer.cornerRadius  = 50;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.superview);
            make.centerY.equalTo(button.superview.mas_top);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        button;
    });
    
    
    [[self.roundButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"red round button action");
    }];
    
}


///view有一个subView叫做eventSubView，要求触摸eventSubView时,eventSubView会响应事件，而触摸view本身，不会响应该事件
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
//    if (view == self.eventSubView) {
//        return view;
//    }
//    return nil;
    
    CGPoint touchPoint = [self.roundButton convertPoint:point fromView:self];
    if ([self.roundButton pointInside:touchPoint withEvent:event]) {
        return self.roundButton;
    }
    
    if (view == self) {
        return nil;
    }
    return view;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 获取UITouch对象
   UITouch *touch = [touches anyObject];
    
    CGPoint preP = [touch previousLocationInView:self];
    CGPoint curP = [touch locationInView:self];
    
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;
    
    // 形变也是相对上一次形变(平移)
    // CGAffineTransformMakeTranslation:会把之前形变给清空,重新开始设置形变参数
    // make:相对于最原始的位置形变
    // CGAffineTransform t:相对这个t的形变的基础上再去形变
    // 如果相对哪个形变再次形变,就传入它的形变
    
        self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
   
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
