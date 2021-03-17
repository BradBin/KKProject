//
//  KKTimer.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/7/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKTimer : NSObject

-(instancetype)initWithName:(NSString *)name;

-(void)fire;

-(void)pause;

-(void)resume;

-(void)invalidate;

@end

NS_ASSUME_NONNULL_END
