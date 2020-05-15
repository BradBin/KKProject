//
//  KKGCDViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/14.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKGCDViewController.h"
#import "KKDispatchSemaphoreSellTicket.h"

@interface KKGCDViewController ()

@property (nonatomic, strong) UIButton *dtpBarrierButton;
@property (nonatomic, strong) UIButton *dtpApplyButton;
@property (nonatomic, strong) UIButton *dtpGroupButton;
@property (nonatomic, strong) UIButton *dtpSemaphoreButton;

@end

@implementation KKGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dtpBarrierButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"dispatch_barrier" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.superview).offset(168);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.dtpApplyButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"dispatch_apply" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dtpBarrierButton).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.dtpGroupButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"dispatch_group" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dtpApplyButton).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.dtpSemaphoreButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"dispatch_semaphore_t" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dtpGroupButton).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    
    
    @weakify(self);
    [[self.dtpBarrierButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dispatchBarrier];
    }];
    
    [[self.dtpApplyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dispatchApply];
    }];
    
    [[self.dtpGroupButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        //两个函数实现同样的功能
        //        [self dispatchGroup];
        
        [self dispatchEnterLeave];
    }];
    
    [[self.dtpSemaphoreButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[[KKDispatchSemaphoreSellTicket alloc] init] sellTickt];
    }];
    
    
}


//快速迭代dispatch_apply:会等待全部任务执行完毕
-(void)dispatchApply{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"dispatch_apply----begin");
    dispatch_apply(6, queue, ^(size_t idx) {
        NSLog(@"dispath_apply : %zd %@",idx,NSThread.currentThread);
    });
    NSLog(@"dispatch_apply----end");
}



/**********************************************
 dispatch_group_wait:所有任务执行完成之后，才执行,但会阻塞当前线程.
 dispatch_group_notify:监听 group 中任务的完成状态,都执行完成后，追加任务到 group 中,才执行.
 
 dispatch_group_enter与dispatch_group_leave组合,可以实现等同于dispatch_group_async
 
 ************************************************/

/// 队列组Dispatch_group:监听 group 中任务的完成状态，当所有的任务都执行完成后，追加任务到 group 中，并执行任务。
-(void)dispatchGroup{
    NSLog(@"group---begin");
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:5];              // 模拟耗时操作
        NSLog(@"任务1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:3];              // 模拟耗时操作
        NSLog(@"任务2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:4];              // 模拟耗时操作
        NSLog(@"任务3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
#if 1
    //dispatch_group_wait:所有任务执行完成之后，才执行,但会阻塞当前线程.
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"group---end");
#else
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务 1、任务 2 都执行完毕后，回到主线程执行下边任务
        NSLog(@"group---end");
    });
    
#endif
}


-(void)dispatchEnterLeave{
    NSLog(@"group---begin");
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"任务1---%@",[NSThread currentThread]); // 打印当前线程
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5]; // 模拟耗时操作
        NSLog(@"任务2---%@",[NSThread currentThread]); // 打印当前线程
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:4]; // 模拟耗时操作
        NSLog(@"任务3---%@",[NSThread currentThread]); // 打印当前线程
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        NSLog(@"group---end");
    });
}



-(void)dispatchBarrier{
    //使用dispatch_barrier_async注意queue必须是CONCURRENT
    NSLog(@"dispathc_barrier_async----begin");
#if 0
    
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"任务1: handle task success!");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:7];
        NSLog(@"任务2 : handle task success!");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"任务3 : handle task success!");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async: 前面的任务都处理完成!");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务处理完成: 结果回调!");
        NSLog(@"dispathc_barrier_async----end");
    });
    
#else
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT);
    
    dispatch_async(globalQueue, ^{
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"download task1 successed!");
    });
    
    dispatch_async(globalQueue, ^{
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"download task2 successed!");
    });
    
    dispatch_barrier_async(globalQueue, ^{
        NSLog(@"barrier blcok success!");
    });
    
    dispatch_async(globalQueue, ^{
        NSLog(@"upload task successed!");
    });
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
