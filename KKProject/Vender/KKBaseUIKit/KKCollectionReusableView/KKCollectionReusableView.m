//
//  KKCollectionReusableView.m
//  ot-dayu
//
//  Created by 尤彬 on 2019/1/7.
//  Copyright © 2019 YangCK. All rights reserved.
//

#import "KKCollectionReusableView.h"

@implementation KKCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self kk_setupViews];
        [self kk_setupConfig];
    }
    return self;
}


- (void)kk_setupViews{}

-(void)kk_setupConfig{}


@end
