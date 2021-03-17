//
//  KKTableView.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/7/6.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTableView.h"

@implementation KKTableView

/// 识别多手势
/// @param gestureRecognizer gestureRecognizer
/// @param otherGestureRecognizer otherGestureRecognizer
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
