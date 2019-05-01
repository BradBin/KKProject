//
//  KKModel.m
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/9/10.
//  Copyright © 2018 youbin. All rights reserved.
//

#import "KKModel.h"


@implementation KKModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

-(id)copyWithZone:(NSZone *)zone{
   return  [self modelCopy];
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return [self mutableCopy];
}

-(BOOL)isEqual:(id)object{
    return [self modelIsEqual:object];
}

-(NSUInteger)hash{
    return [self modelHash];
}

//
//- (id)copyWithZone:(NSZone *)zone {
//    id copyInstance = [[[self class] allocWithZone:zone] init];
//    size_t instanceSize = class_getInstanceSize([self class]);
//    memcpy((__bridge void *)(copyInstance), (__bridge const void *)(self), instanceSize);
//    return copyInstance;
//}
//
//-(id)mutableCopyWithZone:(NSZone *)zone{
//    id mutableCopyInstance = [[[self class] allocWithZone:zone] init];
//    size_t instanceSize = class_getInstanceSize([self class]);
//    memcpy((__bridge void *)(mutableCopyInstance), (__bridge const void *)(self), instanceSize);
//    return mutableCopyInstance;
//}


@end
