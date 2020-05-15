//
//  KKDispatchSemaphoreSellTicket.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/14.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDispatchSemaphoreSellTicket.h"

#define FLAG 1


@interface KKDispatchSemaphoreSellTicket ()

@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic, assign) NSInteger soldCount;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation KKDispatchSemaphoreSellTicket

- (void)sellTickt{
    
    //注意:FLAG为1和0,执行结果
#if FLAG
    self.semaphore = dispatch_semaphore_create(1);
#else
    self.semaphore = dispatch_semaphore_create(0);
#endif
    
    self.tickets = @[@"南京-北京A101",@"南京-北京A102",@"南京-北京A103",@"南京-北京A104",@"南京-北京A105",@"南京-北京A106",@"南京-北京A107",@"南京-北京A108",@"南京-北京A109",@"南京-北京A110",@"南京-北京A111",@"南京-北京A112",@"南京-北京A113",@"南京-北京A114",@"南京-北京A115",@"南京-北京A116",@"南京-北京A117",@"南京-北京A118",@"南京-北京A119",@"南京-北京A120",@"南京-北京A121",@"南京-北京A122",@"南京-北京A123",@"南京-北京A124",@"南京-北京A125",@"南京-北京A126",@"南京-北京A127",@"南京-北京A128",@"南京-北京A129",@"南京-北京A130"];
    
    dispatch_queue_t windowQueueOne   = dispatch_queue_create("窗口1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t windowQueueTwo   = dispatch_queue_create("窗口2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t windowQueueThree = dispatch_queue_create("窗口3", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t windowQueueFour  = dispatch_queue_create("窗口4", DISPATCH_QUEUE_SERIAL);
    
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(windowQueueOne, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ticket];
    });
    
    dispatch_async(windowQueueTwo, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ticket];
    });
    
    dispatch_async(windowQueueThree, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ticket];
    });
    
    dispatch_async(windowQueueFour, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ticket];
    });
}


-(void)ticket{
    
#if FLAG
      
    //加锁
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    if (self.soldCount >= self.tickets.count) {
        NSLog(@"卖完=========%@ 剩余票数: %lu",NSThread.currentThread.name,self.tickets.count-self.soldCount);
        //解锁
        dispatch_semaphore_signal(self.semaphore);
        return;
    }
    // 延时卖票
    [NSThread sleepForTimeInterval:0.2];
    self.soldCount += 1;
    NSLog(@"======%@ %@ 剩余票数:%lu",NSThread.currentThread.name,self.tickets[self.soldCount - 1],self.tickets.count - self.soldCount);
    //解锁
    dispatch_semaphore_signal(self.semaphore);
    //一直卖票
    [self ticket];
#else

    dispatch_semaphore_signal(self.semaphore);
    if (self.soldCount >= self.tickets.count) {
        NSLog(@"卖完=========%@ 剩余票数: %lu",NSThread.currentThread.name,self.tickets.count-self.soldCount);
        //解锁
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        return;
    }
    // 延时卖票
    [NSThread sleepForTimeInterval:0.2];
    self.soldCount += 1;
    NSLog(@"======%@ %@ 剩余票数:%lu",NSThread.currentThread.name,self.tickets[self.soldCount - 1],self.tickets.count - self.soldCount);
    //解锁
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    //一直卖票
    [self ticket];
    
#endif
    
}

@end
