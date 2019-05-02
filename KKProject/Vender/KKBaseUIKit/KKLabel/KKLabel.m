//
//  KKLabel.m
//  kkorange
//
//  Created by YangCK on 2018/4/17.
//  Copyright © 2018年 YangCK. All rights reserved.
//

#import "KKLabel.h"

@implementation KKLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation KKFitSizeLabel

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (CGSize)intrinsicContentSize {
    CGSize originSize = [super intrinsicContentSize];
    return CGSizeMake(originSize.width + 2 * self.leftRightMargin, originSize.height + 2 * self.topBottomMargin);
}

@end
