//
//  KKThread.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/12.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKThread.h"

@interface KKThread ()

@end

@implementation KKThread


///子线程执行完任务后,就会销毁.

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
