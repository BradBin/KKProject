//
//  KKLayout.m
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/11/7.
//  Copyright © 2018 youbin. All rights reserved.
//

#import "KKLayout.h"

CGFloat const marginText = 5.15;

@implementation KKLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _marginTop    = marginText;
        _marginBottom = marginText;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}


@end
