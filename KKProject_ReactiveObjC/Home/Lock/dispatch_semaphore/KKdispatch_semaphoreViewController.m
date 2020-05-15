//
//  KKdispatch_semaphoreViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/13.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKdispatch_semaphoreViewController.h"



@interface KKdispatch_semaphoreViewController ()

@property (nonatomic, strong) UIButton *asyncQueueButton;
@property (nonatomic, strong) UIButton *dispatchSemaphoreButton;
@property (nonatomic, strong) UIButton *semaphoreNetworkingButton;


@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation KKdispatch_semaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.asyncQueueButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"async+queue" forState:UIControlStateNormal];
        button.backgroundColor = UIColor.redColor;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.superview).offset(168);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.5);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.dispatchSemaphoreButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"dispatchSemaphore" forState:UIControlStateNormal];
        button.backgroundColor = UIColor.redColor;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.asyncQueueButton.mas_bottom).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.5);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    @weakify(self);
    [[self.asyncQueueButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dispatch_async_queue];
    }];
    
    [[self.dispatchSemaphoreButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.semaphore = dispatch_semaphore_create(0);
        [self dispatch_semaphore];
    }];
    
    // Do any additional setup after loading the view.
}



/// 异步线程 + 串行队列
-(void)dispatch_async_queue{
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"任务1 : %@",NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2 : %@",NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3 : %@",NSThread.currentThread);
    });
}

///同步和异步决定了是否开启新线程
///串行和并发决定了任务的执行方式

/// 异步线程同步
-(void)dispatch_semaphore{

    ///注意信号量的初始值决定wait和signal函数的调用关系
#if 0
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1 : %@",NSThread.currentThread);
        dispatch_semaphore_signal(self.semaphore);
    });
    
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2 : %@",NSThread.currentThread);
        dispatch_semaphore_signal(self.semaphore);
    });
    
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"3 : %@",NSThread.currentThread);
        dispatch_semaphore_signal(self.semaphore);
    });
    
#else
    

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1 : %@",NSThread.currentThread.name);
        dispatch_semaphore_signal(self.semaphore);
    });
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2 : %@",NSThread.currentThread.name);
        dispatch_semaphore_signal(self.semaphore);
    });
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"3 : %@",NSThread.currentThread.name);
        dispatch_semaphore_signal(self.semaphore);
    });
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
#endif
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
