//
//  KKRunLoopController.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/10.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKRunLoopController : KKViewController

@end

/// Autorelease  AFNetworking3.0后为什么不再需要常驻线程？


/*******************************************
            RunLoop
 
 runloop是一种寄生于线程的消息循环机制,它能保证线程的存活,
 而不是线程执行完任务后就消亡.
  特性:
    1.runloop和线程是一一对应的,每个线程只有唯一与之对应的一个
 runloop.我们不能创建runloop,只能在当前线程中获取线程对应的runloop(
 主线程runloop除外).
    2.子线程默认没有runloop,需要我们主动去开启;但是主线程是自动开启runloop
 的,以保证应用程序的执行运行,接收并处理各种事件.
    3.runloop想要正常启动,需要运行在添加了事件源的mode下,否则会自动退出;一
 个runloop可以拥有多个mode,mode可以拥有多个Source/Timer/Observer
 
 runloop有三种启动方式:1.run 2.runUntilDate 3.runMode:beforeDate:
 1.run : 无条件永远运行Runloop并且无法停止,线程永远存在.在NSDafaultRunLoopMode 模式下运行.
 2.runUntilDate:会在指定时间到达后退出runloop,同样无法主动停止runloop,在NSDafaultRunLoopMode 模式下运行.
 3.runMode:beforeDate: 可以选定运行模式,并且在时间到达后或者触发了飞Timer的事件后退出.
 
 
 iOS系统中提供了两种runloop:NSRunLoop和CFRunloopRef.
 CFRunLoopRef是在CoreFoundation框架内,提供了纯C函数API,是线程安全的.
 NSRunLoop是基于CFRunLoopRef的封装,提供了面向对象的API,不是线程安全的.
 
 
 [NSRunLoop currentRunLoop] :当前线程的RunLoop
 [NSRunLoop mainRunLoop]:主线程的RunLoop
 



********************************************/

NS_ASSUME_NONNULL_END
