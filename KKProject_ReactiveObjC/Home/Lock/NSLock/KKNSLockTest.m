//
//  KKNSLockTest.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/13.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKNSLockTest.h"

@interface KKNSLockTest ()

@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic, assign) NSInteger soldCount;
@property (nonatomic, strong) NSLock    *lock;

@end

@implementation KKNSLockTest

- (void)forTest{
   self.tickets = @[@"南京-北京A101",@"南京-北京A102",@"南京-北京A103",@"南京-北京A104",@"南京-北京A105",@"南京-北京A106",@"南京-北京A107",@"南京-北京A108",@"南京-北京A109",@"南京-北京A110",@"南京-北京A111",@"南京-北京A112",@"南京-北京A113",@"南京-北京A114",@"南京-北京A115",@"南京-北京A116",@"南京-北京A117",@"南京-北京A118",@"南京-北京A119",@"南京-北京A120",@"南京-北京A121",@"南京-北京A122",@"南京-北京A123",@"南京-北京A124",@"南京-北京A125",@"南京-北京A126",@"南京-北京A127",@"南京-北京A128",@"南京-北京A129",@"南京-北京A130"];
    //初始化NSLock
    self.lock = [[NSLock alloc] init];
    //第一窗口
    NSThread *windowOne = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    windowOne.name = @"一号窗口";
    [windowOne start];
    //第二窗口
    NSThread *windowTwo = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    windowTwo.name = @"二号窗口";
    [windowTwo start];
    //第三窗口
    NSThread *windowThree = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    windowThree.name = @"三号窗口";
    [windowThree start];
    //第四窗口
    NSThread *windowFour = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    windowFour.name = @"四号窗口";
    [windowFour start];
}



-(void)soldTicket{
     //加锁
      [self.lock lock];
      if (self.soldCount == self.tickets.count) {
          NSLog(@"=====%@ 剩余票数：%lu",[[NSThread currentThread] name],self.tickets.count-self.soldCount);
          //解锁
          [self.lock unlock];
          return;
      }
      //延时卖票
    [NSThread sleepForTimeInterval:0.2];
      self.soldCount++;
      NSLog(@"=====%@ %@ 剩%lu",[[NSThread currentThread] name],self.tickets[self.soldCount-1],self.tickets.count-self.soldCount);
      //解锁
      [self.lock unlock];
      //一直卖票
      [self soldTicket];
}

/********************************************

注意:
 1.NSLock不能两次加锁,否则就会死锁.
 2.lock和unlock是成对出现.
 
 3.加锁的目的:每个窗口只能卖不同的票,避免出现一张在不同窗口售卖.

*********************************************/

@end
