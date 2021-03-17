//
//  KKTimer.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/7/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTimer.h"

@interface KKTimer()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation KKTimer

-(instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
