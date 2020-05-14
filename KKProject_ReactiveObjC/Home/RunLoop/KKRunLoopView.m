//
//  KKRunLoopView.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/12.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKRunLoopView.h"


#define textString @"当前对象指定在某个线程上完成某个任务，常用的就是performSelectorOnMainThread 回到主线程更新UI。这种方式称为 Event Loop ，即线程一直处于等待接收执行任务消息状态，一旦有消息，再去执行对应的任务，这和直接被赋予某一种任务是不同的，后者一旦执行完任务后就进入死亡状态，不可再用，前者则一直处于等待状态，有任务就去执行，没任务就进入休眠，不占用系统多余的资源"

@interface KKRunLoopView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextView  *textView;
@property (nonatomic, strong) UIImageView *imageView;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UIButton *changeRunLoopButton;

@end

@implementation KKRunLoopView

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
    self.scrollView = ({
        UIScrollView *view = UIScrollView.new;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview);
            make.centerX.equalTo(view.superview);
            make.width.equalTo(view.superview);
            make.bottom.equalTo(view.superview);
        }];
        view;
    });
    
    self.imageView = ({
        UIImageView *view = UIImageView.new;
        view.clipsToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.backgroundColor = UIColor.darkTextColor;
        [self.scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top).offset(40);
            make.centerX.equalTo(view.superview);
            make.width.equalTo(view.superview).multipliedBy(0.6);
            make.height.equalTo(view.mas_width);
        }];
        view;
    });
    
    self.textView = ({
        UITextView *view = UITextView.new;
        view.backgroundColor = UIColor.lightGrayColor;
        view.font = [UIFont systemFontOfSize:20];
        view.text = textString;
        [self.scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(30);
            make.centerX.equalTo(view.superview);
            make.width.equalTo(view.superview).multipliedBy(0.75);
            make.height.mas_equalTo(180);
        }];
        view;
    });

    
    self.changeRunLoopButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"改变timer的runloopMode" forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        button;
    });
    
    self.timerLabel = ({
        UILabel *label = UILabel.new;
        label.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.changeRunLoopButton.mas_bottom).offset(80);
            make.centerX.equalTo(label.superview);
            make.width.equalTo(label.superview.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        label;
    });
    
    
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.timerLabel.mas_bottom).offset(500);
    }];
}

- (void)bindViewModel{

    [self createTimer];
    @weakify(self);
    [[self.changeRunLoopButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        x.selected = !x.selected;
        if (x.selected) {
            NSLog(@"NSRunLoopCommonModes");
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        }else{
            NSLog(@"NSDefaultRunLoopMode");
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        }
    }];
    
}

-(void)createTimer{
    self.timer = ({
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerCaculate) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [timer fire];
        timer;
    });
}

- (void)timerCaculate{
    static int count = 1;
    count += 1;
    [[NSRunLoop currentRunLoop] runUntilDate:NSDate.date];
    self.timerLabel.text = [NSString stringWithFormat:@"%@",@(count)];
}


/********************************************
 一个线程一次只能执行一个任务，执行完成后线程就会退出。如
 果我们需要一个机制，让线程能随时处理事件但并不退出，这种
 模型通常被称作 Event Loop
 *********************************************/

-(void)dealloc{
    self.timer = nil;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
