//
//  KKHomeLayout.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeLayout.h"

@implementation KKHomeLayout

+ (instancetype)kk_layoutWithModel:(KKHomeContentModel *)model{
    return [[self alloc] initWithModel:model];
}

- (instancetype)initWithModel:(KKHomeContentModel *)model
{
    self = [super init];
    if (self) {
        [self kk_layout];
    }
    return self;
}

- (void)kk_layout{
    
}


@end
