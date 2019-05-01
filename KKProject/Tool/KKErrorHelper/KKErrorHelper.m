//
//  KKErrorHelper.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKErrorHelper.h"

#pragma mark -
#pragma mark - KKErrorHelper
@implementation KKErrorHelper
    

@end





#pragma mark -
#pragma mark - KKErrorHelper(VCControl)

#import <objc/runtime.h>
#import "AppDelegate.h"
#import "KKLoginViewController.h"
#import "KKTabBarController.h"
#import "KKAccountHelper.h"

static NSString * const currentVCKey              = @"currentVCKey";
NSNotificationName KKHideLiveRoomNotificationName = @"KK.Hide.LiveRoom.Notification.Name";
@implementation KKErrorHelper(VCControl)
    
+(instancetype)shared{
    static KKErrorHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[KKErrorHelper alloc] init];
    });
    return _instance;
}
    
-(UIViewController *)currentVC{
    return objc_getAssociatedObject(self, &currentVCKey);
}
    
-(void)setCurrentVC:(UIViewController *)currentVC{
    objc_setAssociatedObject(self, &currentVCKey, currentVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
   
+(void)kk_showLoginVC{
    [self kk_showLoginVCWithMessage:nil];
}
    
+(void)kk_showLoginVCWithMessage:(NSString *)message{
    KKErrorHelper *shared = [KKErrorHelper shared];
    if (![shared.currentVC isKindOfClass:KKLoginViewController.class]) {
        [NSNotificationCenter.defaultCenter postNotificationName:KKHideLiveRoomNotificationName object:nil];
        [KKAccountHelper kk_logOut];
        KKLoginViewController *loginVC = [self creatLoginVC];
        [self transitionToVC:loginVC];
        shared.currentVC = loginVC;
        if (message.isNotBlank) {
        }
    }
}
    
+(void)kk_showHomeVC{
    KKErrorHelper *shared = [KKErrorHelper shared];
    if (![shared.currentVC isKindOfClass:KKLoginViewController.class]) {
        KKTabBarController *tabBarVC = [self creatTabBarVC];
        [self transitionToVC:tabBarVC];
        shared.currentVC = tabBarVC;
    }
}

+ (UIViewController *)kk_defaultVC {
    KKAccountHelper *helper = KKAccountHelper.shared;
    KKErrorHelper *manager = [KKErrorHelper shared];
    BOOL isLogin   = helper.isLogin; // 是否登录
    BOOL isExpired = helper.isExpired; //是否过期
    UIViewController *resultVC;
    if (isLogin && !isExpired ) {
        KKTabBarController *tabBarVC = [self creatTabBarVC];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBarVC];
        manager.currentVC = tabBarVC;
        resultVC = nav;
    }else {
        KKLoginViewController *loginVC = [self creatLoginVC];
        UINavigationController *loginNavVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        resultVC = loginNavVC;
        manager.currentVC = loginVC;
    }
    return resultVC;
}

+ (KKLoginViewController *)creatLoginVC {
    KKLoginViewController *loginVC = [KKLoginViewController new];
    return loginVC;
}

+ (KKTabBarController *)creatTabBarVC {
    KKTabBarController *tabBarVC = KKTabBarController.new;
    return tabBarVC;
}

+ (void)transitionToVC:(UIViewController *)viewController {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    app.window.rootViewController = nav;
    [UIView transitionWithView:app.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}
    
@end
