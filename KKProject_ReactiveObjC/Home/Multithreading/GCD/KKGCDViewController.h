//
//  KKGCDViewController.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/14.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKGCDViewController : KKViewController

@end

/***********************************************

 GCD的部分方法:
 
 延时方法:dispatch_after
 只执行一次方法:dispatch_once
 dispatch_apply(快速迭代方法):按照指定的次数将指定任务追加到指定的队列中,并等待全部队列执行结束.
 队列组:dispatch_group
 信号量:dispatch_semaphore_t
 
 
 
 栅栏方法:dispatch_barrier
 在前面的任务完成后再去执行后面的某些操作,我们可以采用dispatch_barrier_async来轻松实现.
 dispatch_barrier是跟dipatch_async/dispatch_sync 相似的api,用来将任务提交到指定队列中,它的使用注意点:queue必须
 是DISPATCH_QUEUE_CONCURRENT类型的.queue如果是global或者不是DISPATCH_QUEUE_CONCURRENT类
 型的其他queue,它的作用就和普通的dipatch_async/dispatch_sync一样.


************************************************/

NS_ASSUME_NONNULL_END
