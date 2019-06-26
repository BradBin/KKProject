//
//  KKHomeLayout.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeLayout.h"

@implementation KKHomeLayout

+ (instancetype)kk_layoutWithModel:(KKHomeContentModel *)content{
    return [[self alloc] initWithModel:content];
}

- (instancetype)initWithModel:(KKHomeContentModel *)content
{
    self = [super init];
    if (self) {
        _content = content;
        [self kk_layout];
    }
    return self;
}

- (void)kk_layout{
    _height = 0.0f;
    [self kk_titleLayout];
    
    if (_titleLayout.height) _height += _titleLayout.height;
    
    if (_height) {
        _height += self.marginTop;
        _height += self.marginBottom;
    }
}

- (void)kk_titleLayout{
    
}

@end
