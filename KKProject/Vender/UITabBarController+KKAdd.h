//
//  UITabBarController+KKAdd.h
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/9/10.
//  Copyright © 2018 youbin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIView (KKAddAnimation)

- (CABasicAnimation *)rotationAnimation;
- (void)stopRotationAnimation;

@end



@interface UITabBar (KKAdd)

- (void) showBadgeOnItemIndex:(NSInteger) index badge:(NSInteger ) badge;
- (void) hideBadgeOnItemIndex:(NSInteger) index;

@end

@interface UITabBarController (KKAdd)

- (UIViewController *) kk_addChildVCInTabBarWithViewController:(UIViewController *)vc
                                           title:(NSString *)title
                                           badge:(NSUInteger)badge
                                           image:(UIImage *)image
                                   selectedImage:(UIImage *)selectedImage;


@end

NS_ASSUME_NONNULL_END
