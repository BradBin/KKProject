//
//  KKAccount.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/16.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKAccount.h"

@implementation KKAccount

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

@end
