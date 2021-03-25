//
//  KKDispatchSemaphoreSellTicket.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/14.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*************************************
     dispatch_semaphore_t信号量
 
 
 
 
 *************************************/

@interface KKDispatchSemaphoreSellTicket : NSObject


/// 卖火车票
-(void)sellTickt;

@end

NS_ASSUME_NONNULL_END
