//
//  KKLayout.h
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/11/7.
//  Copyright © 2018 youbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYTextLinePositionModifier.h"

NS_ASSUME_NONNULL_BEGIN
/**
 默认边界距离 5.15
 */
FOUNDATION_EXTERN  CGFloat const marginText;

@interface KKLayout : NSObject

/**
 默认上边界距离 5.15
 */
@property (nonatomic,assign) CGFloat marginTop;
/**
 默认下边界距离 5.15
 */
@property (nonatomic,assign) CGFloat marginBottom;

@end

NS_ASSUME_NONNULL_END
