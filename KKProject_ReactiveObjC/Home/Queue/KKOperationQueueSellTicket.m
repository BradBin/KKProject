//
//  KKOperationQueueSellTicket.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/15.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKOperationQueueSellTicket.h"


@interface KKOperationQueueSellTicket ()

@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic, assign) NSInteger soldCount;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation KKOperationQueueSellTicket

-(void)sellTicket{
    
    self.semaphore = dispatch_semaphore_create(1);
    self.tickets = @[@"南京-北京A101",@"南京-北京A102",@"南京-北京A103",@"南京-北京A104",@"南京-北京A105",@"南京-北京A106",@"南京-北京A107",@"南京-北京A108",@"南京-北京A109",@"南京-北京A110",@"南京-北京A111",@"南京-北京A112",@"南京-北京A113",@"南京-北京A114",@"南京-北京A115",@"南京-北京A116",@"南京-北京A117",@"南京-北京A118",@"南京-北京A119",@"南京-北京A120",@"南京-北京A121",@"南京-北京A122",@"南京-北京A123",@"南京-北京A124",@"南京-北京A125",@"南京-北京A126",@"南京-北京A127",@"南京-北京A128",@"南京-北京A129",@"南京-北京A130"];
    
    
    //创建卖票窗口
    NSOperationQueue *windowOne = NSOperationQueue.alloc.init;
    windowOne.maxConcurrentOperationCount = 1;
    
    NSOperationQueue *windowTwo = NSOperationQueue.alloc.init;
    windowTwo.maxConcurrentOperationCount = 1;
    
    NSOperationQueue *windowThree = NSOperationQueue.alloc.init;
    windowThree.maxConcurrentOperationCount = 1;
    
    NSOperationQueue *windowFour = NSOperationQueue.alloc.init;
    windowFour.maxConcurrentOperationCount = 1;
    
    @weakify(self);
    [windowOne addOperationWithBlock:^{
        @strongify(self);
        [self ticket];
    }];
    
    [windowTwo addOperationWithBlock:^{
        @strongify(self);
        [self ticket];
    }];
    
    [windowThree addOperationWithBlock:^{
        @strongify(self);
        [self ticket];
    }];
    
    [windowFour addOperationWithBlock:^{
        @strongify(self);
        [self ticket];
    }];
}

-(void)ticket{
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    if (self.soldCount >= self.tickets.count) {
        NSLog(@"票已经卖完!");
        dispatch_semaphore_signal(self.semaphore);
        return;
    }
    
    [NSThread sleepForTimeInterval:0.5];
    self.soldCount += 1;
    
    NSLog(@"%@ %@ 剩余 %zd",NSThread.currentThread,self.tickets[self.soldCount - 1], self.tickets.count - self.soldCount);
    
    dispatch_semaphore_signal(self.semaphore);
    
    ///一直卖票
    [self ticket];
}

@end
