//
//  KKNSLockViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/13.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKNSLockViewController.h"
#import "KKNSLockTest.h"

@interface KKNSLockViewController ()

@property (nonatomic, strong) NSMutableArray *mArray;

@end

@implementation KKNSLockViewController

/**********************************************
 
 NSLock:对象锁,属于互斥锁,是对pthread_mutex做了一层简单的封装
 -(BOOL)tryLock;//尝试加锁，不会阻塞线程。true则加锁成功，false则失败，说
 明其他线程在加锁中这个方法无论如何都会立即返回。

 -(BOOL)lockBeforeDate:(NSDate *)limit;//尝试在指定NSDate之前加锁，会阻塞线程。true则加
 锁成功，false则失败，说明其他线程在加锁中这个方法无论如何都会立即返回。在拿不到锁时不会一直在那等待。
 该线程将被阻塞，直到获得了锁，或者指定时间过期。
 @property (nullable, copy) NSString *name;线程锁名称
 
 
 
 非递归锁，当同一线程重复获取同一非递归锁时，就会发生死锁;
 递归锁：它允许同一线程多次加锁，而不会造成死锁
 NSLock *m_lock;
 [m_lock lock]; // 成功上锁
 do something....
 [m_lock lock]; // 上面已经上锁，这里阻塞等待锁释放，不会再执行下面，锁永远得不到释放，即死锁
 do something....
 [m_lock unlock]; // 不会执行到
 do something....
 [m_lock unlock];
 
 ***********************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
  //火车站卖票
    //[[[KKNSLockTest alloc] init] forTest];
    
    /***
     运行该程序会崩溃，这是因为，我们在不断地
     创建array，mArray在不断的赋新值，释放旧
     值，这个时候多线程操作就会可能存在值已经被
     释放了，而其他线程还在操作，此时就会发生崩溃
     */
//    for (int i = 0; i < 200; i++) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            self.mArray = [NSMutableArray array];
//        });
//    }
    
    
    
    /********
     此时就需要我们对程序加锁
     程序就能正常运行了，这是因为此时，每一条线程
     执行self.mArray = [NSMutableArray array]的
     前后，都会有获取锁释放锁的过
     程，此时这句代码是在线程安全
     的情况下执行的，所以并没有异常问题
     *******/
    NSLock *lock = [[NSLock alloc] init];
    for (int i = 0; i < 200; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [lock lock];
            self.mArray = [NSMutableArray array];
            [lock unlock];
        });
    }
}






/*********************************************
 NSLock其实只是对pthread_mutex做了一层简单的封装。它属
 于互斥锁的一种。当一个线程进行访问的时候，该线程获得锁，其
 他线程进行访问的时候，将被操作系统挂起，直到该线程释放锁，其
 他线程才能对其进行访问，从而却确保了线程安全。

 
 通过结果，我们可以看到虽然程序先进入线程1，但是由于我们在执行lock加入了延迟，由于是并发操作，所以紧接着，会进入线程2，线程2可以立即执行lock操作，虽然我们紧接着sleep了5秒钟，但是由于锁已经被线程2占用，并不会去执行线程1的操作，此时线程1就被阻塞了，只有等到线程2执行完成解锁之后才会进入线程1执行任务。这也就完美的体现了互斥锁的特性。

**********************************************/
- (void)nslockTest {
    NSLock *lock = [[NSLock alloc] init];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"进入线程1");
        sleep(2);
        [lock lock];
        NSLog(@"执行任务1");
        [lock unlock];
        NSLog(@"退出线程1");
    });
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"进入线程2");
        [lock lock];
        sleep(5);
        NSLog(@"执行任务2");
        [lock unlock];
        NSLog(@"退出线程2");
    });
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
