//
//  KKThreadViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/12.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKThreadViewController.h"
#import "KKThread.h"

@interface KKThreadViewController ()

@property (nonatomic, strong) KKThread *thread;

@end

@implementation KKThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// 常规模式
//    KKThread *thread = [[KKThread alloc] initWithTarget:self selector:@selector(runTask) object:nil];
    //保持线程长时间存活
    KKThread *thread = [[KKThread alloc] initWithTarget:self selector:@selector(keepThreadLive) object:nil];
    thread.name = @"测试线程";
    [thread start];
    self.thread = thread;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(runTask) onThread:self.thread withObject:nil waitUntilDone:false];
}

#pragma mark -保证线程的长时间存活
/// 子线程启动后，启动runloop
- (void)keepThreadLive{
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // //如果注释了下面这一行，子线程中的任务并不能正常执行
    [runLoop addPort:NSMachPort.port forMode:NSRunLoopCommonModes];
    NSLog(@"启动RunLoop前--%@  %@",runLoop.currentMode,NSRunLoop.mainRunLoop.currentMode);
    [runLoop run];
}


/// 子线程任务
- (void)runTask{
    NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:2.0];
    NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
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
