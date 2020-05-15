//
//  KKOPerationQueueViewController.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/15.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKOPerationQueueViewController : KKViewController

@end


/***************************************************
 NSOperation是基于GCD的封装
 
 NSOperation:是线程中执行的那段代码.
 子类NSInvocationOperation,NSBlockOperation或者自定义NSOperation
 
 NSOperationQueue不同于GCD中调度队列FIFO(先进先出)的原则,添加到队列中
 的操作,首先进入就绪状态(就绪状态取决于操作之间的依赖关系)

****************************************************/

NS_ASSUME_NONNULL_END
