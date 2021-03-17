//
//  KKTimerViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/7/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTimerViewController.h"

@interface KKTimerViewController ()

@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) __block NSUInteger count;

@end

@implementation KKTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.count = 0;
    
    self.startButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@" start " forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.superview.mas_top).offset(148);
            make.centerX.equalTo(button.superview);
            make.height.mas_equalTo(30);
        }];
        button;
    });
    self.pauseButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@" pause " forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.startButton.mas_bottom).offset(30);
            make.centerX.equalTo(button.superview);
            make.height.mas_equalTo(30);
        }];
        button;
    });
    self.resumeButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@" resume " forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pauseButton.mas_bottom).offset(30);
            make.centerX.equalTo(button.superview);
            make.height.mas_equalTo(30);
        }];
        button;
    });

    self.stopButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@" stop " forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.resumeButton.mas_bottom).offset(30);
            make.centerX.equalTo(button.superview);
            make.height.mas_equalTo(30);
        }];
        button;
    });
    @weakify(self);
    [[self.startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self startGCDTimer];
    }];
    [[self.pauseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self pauseTimer];
    }];
    [[self.resumeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self resumeTimer];
    }];
    [[self.stopButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.count = 0;
        [self stopTimer];
    }];
}




-(void) startGCDTimer{
    NSTimeInterval period = 1.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //在这里执行事件
        self.count ++;
        NSLog(@"每秒执行test: %ld",self.count);
    });
    
    dispatch_resume(_timer);
}
 
 
-(void) pauseTimer{
    if(_timer){
        dispatch_suspend(_timer);
    }
}
-(void) resumeTimer{
    if(_timer){
        dispatch_resume(_timer);
    }
}
-(void) stopTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
