//
//  KKThread.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/12.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKThread : NSThread

@end


/*********************************
 有时候我们不希望一些花费时间比较长的操作阻塞主线程，导致界
 面卡顿，那么我们就会创建一个子线程，然后把这些花费时间比较
 长的操作放在子线程中来处理。可是当子线程中的任务执行完毕后，
 子线程就会被销毁.这是就要使用NSRunLoop
 **********************************/

NS_ASSUME_NONNULL_END
