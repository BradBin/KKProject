//
//  KKLabel.h
//  kkorange
//
//  Created by YangCK on 2018/4/17.
//  Copyright © 2018年 YangCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKLabel : UILabel

@end

@interface KKFitSizeLabel : KKLabel

@property (nonatomic, assign) CGFloat leftRightMargin;
@property (nonatomic, assign) CGFloat topBottomMargin;

@end
