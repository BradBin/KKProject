//
//  UITabBarController+KKAdd.m
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/9/10.
//  Copyright © 2018 youbin. All rights reserved.
//

#import "UITabBarController+KKAdd.h"

#pragma mark - UIView动画分类
@implementation UIView (KKAddAnimation)

- (CABasicAnimation *)rotationAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue   = @0;
    rotationAnimation.toValue     = @(M_PI * 2.0);
    rotationAnimation.duration    = 2;
    rotationAnimation.cumulative  = true;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    return rotationAnimation;
}

- (void)stopRotationAnimation {
    if ([self.layer animationForKey:@"rotationAnimation"]) {
        [self.layer removeAnimationForKey:@"rotationAnimation"];
    }
}

@end





#pragma mark - UITabBar分类
static NSInteger const badgeTag = 876;
@implementation UITabBar (KKAdd)

- (void)showBadgeOnItemIndex:(NSInteger)index badge:(NSInteger)badge{
    
    [self hideBadgeOnItemIndex:index];
    NSString *string;
    BOOL hiden = false;
    if (badge >99) {
        string = [NSString stringWithFormat:@"%ld+",(long)badge];
        hiden = false;
    }else if(badge > 1 && badge <= 99){
        string = [NSString stringWithFormat:@"%ld",(long)badge];
        hiden = false;
    }else{
        string = @"0";
        hiden = true;
    }
    UILabel *badgelabel = [self createLabelWithBadge:string];
    badgelabel.hidden   = hiden;
    badgelabel.tag      = badgeTag + index;
    CGRect frame        = self.frame;
    
    //确定小红点的位置
    float percentX = (index + 0.55) / self.items.count;
    CGFloat x = ceilf(percentX * frame.size.width);
    CGFloat y = ceilf(0.05 * frame.size.height);
    badgelabel.frame = CGRectMake(x, y, badgelabel.frame.size.width, badgelabel.frame.size.height);
    [self addSubview:badgelabel];
}


- (void)hideBadgeOnItemIndex:(NSInteger)index{
    for (UIView *view in self.subviews) {
        if (view.tag == badgeTag + index) {
            [view removeFromSuperview];
        }
    }
}

- (UILabel *) createLabelWithBadge:(NSString *) badgeString{
    UILabel *label = [[UILabel alloc]init];
    label.text = badgeString;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.borderWidth = 1.0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.backgroundColor = [UIColor colorWithRed:0.97 green:0.35 blue:0.35 alpha:1.0];
    label.textColor = [UIColor whiteColor];
    label.clipsToBounds = true;
    [label sizeToFit];
    CGRect rect = label.frame;
    label.frame = CGRectMake(0, 0, rect.size.width + 10 , rect.size.height + 10);
    label.layer.cornerRadius = (rect.size.height + 10) / 2.0;
    return label;
}


@end







@implementation UITabBarController (KKAdd)

+ (void)initialize {
    
    [[UITabBar appearance] setTranslucent:NO];
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0f];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#EFEFEF"] size:CGSizeMake(UIScreen.mainScreen.bounds.size.width, CGFloatPixelRound(0.5))];
    [[UITabBar appearance] setShadowImage:image];
    [[UITabBar appearance] setBackgroundImage:UIImage.new];
    UITabBarItem * item = [UITabBarItem appearance];
    
    //normal
    item.titlePositionAdjustment = UIOffsetMake(0, 0);
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#636564"];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // selected
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#A62EF7"];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

- (UIViewController *) kk_addChildVCInTabBarWithViewController:(UIViewController *)vc
                                           title:(NSString *)title
                                           badge:(NSUInteger)badge
                                           image:(UIImage *)image
                                   selectedImage:(UIImage *)selectedImage{
    vc.title                              = title;
    vc.tabBarItem.badgeValue              = badge? @(badge).stringValue : nil;
    vc.tabBarItem.image                   = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage           = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    [self addChildViewController:vc];
    return vc;
}

@end
