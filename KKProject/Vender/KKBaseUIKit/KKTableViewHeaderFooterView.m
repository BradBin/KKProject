//
//  KKTableViewHeaderFooterView.m
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/10/25.
//  Copyright © 2018 youbin. All rights reserved.
//

#import "KKTableViewHeaderFooterView.h"

@implementation KKTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self kk_setupViews];
        [self kk_setupConfig];
        [self kk_bindViewModel];
    }
    return self;
}

- (void)kk_setupViews{}

-(void)kk_setupConfig{}

-(void)kk_bindViewModel{}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
