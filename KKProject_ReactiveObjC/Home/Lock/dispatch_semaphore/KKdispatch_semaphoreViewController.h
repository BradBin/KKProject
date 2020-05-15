//
//  KKdispatch_semaphoreViewController.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/13.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKdispatch_semaphoreViewController : KKViewController

@end


/*********************************
        dispatch_semaphore_t信号量
 1.信号量的初始化值,可以用来控制线程并发访问的最大数量.
 2.信号量的初始值为1,代表同时只允许1条线程访问资源,保证
 线程同步.
 3.注意:信号量的初始值决定 wait和signal的调用顺序
 For example:
 //表示最多开启5条线程
 dispatch_semaphore_create(5)
 
 //让信号量的值+1
 //发送信号量
 dispatch_semaphore_signal(self.semaphore)
 
 //信号量>0,就让信号量值减1,然后继续执行代码
 //信号量<=0,就会休眠等待,直到信号量的值变成>0,就
 //让信号量的值-1,然后继续往下执行代码
 //等待信号量
 dispatch_semaphore_wait(self.semaphore,DISPATCH_TIME_FOREVER)
 
 
 
 
 
 使用方法:
 等待信号量和发送信号量的函数是成对出现的.
 并发执行任务的时候,当前任务执行之前,用
 dispatch_semaphore_wait函数(-1)进行等
 待(阻塞),直到上一个任务执行完毕且通过
 dispatch_semaphore_signal函数(+1)发
 送信号量,
 
 
 *********************************/

NS_ASSUME_NONNULL_END
