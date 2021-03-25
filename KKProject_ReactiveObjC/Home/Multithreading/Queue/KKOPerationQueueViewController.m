//
//  KKOPerationQueueViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/15.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKOPerationQueueViewController.h"
#import "KKOperationQueueSellTicket.h"

@interface KKOPerationQueueViewController ()

@property (nonatomic, strong) UIButton *invocationButton;
@property (nonatomic, strong) UIButton *blockButton;
@property (nonatomic, strong) UIButton *queueButton;
@property (nonatomic, strong) UIButton *queueDepButton;
@property (nonatomic, strong) UIButton *queueConnectionButton;
@property (nonatomic, strong) UIButton *queueSellTicketButton;

@end

@implementation KKOPerationQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.invocationButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"NSInvocationOperation" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.superview).offset(168);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.blockButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"NSBlockOperation" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.invocationButton.mas_bottom).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.queueButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"NSOperationQueue" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.blockButton.mas_bottom).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.queueDepButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"addDependency" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queueButton.mas_bottom).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.queueConnectionButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"线程通讯" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queueDepButton.mas_bottom).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    self.queueSellTicketButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"卖票" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queueConnectionButton.mas_bottom).offset(80);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.75);
            make.height.mas_equalTo(50);
        }];
        button;
    });
    
    @weakify(self);
    [[self.invocationButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self invocationOperation];
    }];
    
    [[self.blockButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self blockOperation];
    }];
    
    
    [[self.queueButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self operationQueue];
    }];
    
    [[self.queueDepButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self addDependency];
    }];
    
    [[self.queueConnectionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self communication];
    }];
    
    [[self.queueSellTicketButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[[KKOperationQueueSellTicket alloc] init] sellTicket];
    }];
}


-(void)invocationOperation{
    //创建对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task) object:nil];
    //调用执行操作
    [op start];
}


-(void)blockOperation{
    @weakify(self);
    
    ///block中操作和blockOperationWithBlock中操作可能在当前线程或者其他线程中执行
    //有系统决定的
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        @strongify(self);
        [self task];
    }];
    
    [op addExecutionBlock:^{
        NSLog(@" addExecutionBlock 1 %@",NSThread.currentThread);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@" addExecutionBlock 2 %@",NSThread.currentThread);
    }];
    
    [op start];
}


#pragma mark -执行的任务
-(void)task{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", NSThread.currentThread); // 打印当前线程
    }
}



#pragma mark -NSOperationQueue

/********************************
 NSoperationQueue的maxConcurrentOperationCount
 控制队列中同时能并发执行的最大操作数.
 
 ********************************/
-(void)operationQueue{
    
    NSOperationQueue *queue = NSOperationQueue.alloc.init;
    //最大并发操作数: 为1时对列为串行队列,只能串行执行;大于1时队列并发队列
    queue.maxConcurrentOperationCount = 1; //串行队列
    //    queue.maxConcurrentOperationCount = 2; //并行队列
    
    [queue addOperationWithBlock:^{
        for (NSInteger idx = 0; idx < 3; idx ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"addOperationWithBlock 1 : %@ ",NSThread.currentThread);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (NSInteger idx = 0; idx < 3; idx ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"addOperationWithBlock 2 : %@ ",NSThread.currentThread);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (NSInteger idx = 0; idx < 3; idx ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"addOperationWithBlock 3 : %@ ",NSThread.currentThread);
        }
    }];
}

-(void)addDependency{
    
    //创建线程
    NSOperationQueue *queue = NSOperationQueue.alloc.init;
    
    //创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger idx = 0; idx < 2; idx ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"blockOperation 1 : %@",NSThread.currentThread);
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger idx = 0; idx < 2; idx ++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"blockOperation 2 : %@",NSThread.currentThread);
        }
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger idx = 0; idx < 2; idx ++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"blockOperation 3 : %@",NSThread.currentThread);
        }
    }];
    
    //添加依赖关系
    [op2 addDependency:op1];// 让op2依赖op1,先执行op1,再执行op2
    
    [queue addOperation:op2];
    [queue addOperation:op1];
    [queue addOperation:op3];
}

-(void)communication{
    
    NSOperationQueue *queue = NSOperationQueue.alloc.init;
    
    [queue addOperationWithBlock:^{
        for (NSInteger idx = 0; idx < 2; idx ++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"addOperationWithBlock 1");
        }
    }];
    
    if (@available(iOS 13.0, *)) {
        [queue addBarrierBlock:^{
            for (NSInteger idx = 0; idx < 2; idx ++) {
                [NSThread sleepForTimeInterval:1];
                NSLog(@"addBarrierBlock");
            }
        }];
    } else {
        
    }
    
    [queue addOperationWithBlock:^{
        for (NSInteger idx = 0; idx < 2; idx ++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"addOperationWithBlock 2");
        }
        //切回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"线程通讯:切回到主线程");
        }];
    }];
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
