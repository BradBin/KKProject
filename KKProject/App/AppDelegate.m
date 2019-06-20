//
//  AppDelegate.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/4/24.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "AppDelegate.h"
#import "KKLanuchViewController.h"
#import <NIMSDK/NIMSDK.h>

#import <UserNotifications/UserNotifications.h>
#if ENV_CODE == ENV_PROJECT

#elif ENV_CODE == ENV_PROJECT_OBJC
#import <UMPush/UMessage.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //键盘配置
    [self setupKeyboard];
    //导航栏配置
    [self kk_setupNavigationBar];
    //友盟配置
    [self setupUMeng];
    //配置云信SDK
    [self setupNIM];
    //网络BASE_URL
    [KKNetWorking updateBaseUrl:KK_BASE_URL];
    //配置主控制
    [self setupMainVC];
    
    return YES;
}

/**
 导航栏配置
 */
- (void) setupKeyboard{
    IQKeyboardManager *keyboardManager                  = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside          = true;
    keyboardManager.shouldToolbarUsesTextFieldTintColor = true;
    keyboardManager.enableAutoToolbar                   = false;
    keyboardManager.toolbarManageBehaviour              = IQAutoToolbarByTag;
    keyboardManager.shouldResignOnTouchOutside          = true;
    [[IQKeyboardManager sharedManager] registerTextFieldViewClass:[YYTextView class]
                                  didBeginEditingNotificationName:YYTextViewTextDidBeginEditingNotification
                                    didEndEditingNotificationName:YYTextViewTextDidEndEditingNotification];
}


/**
 导航栏配置
 */
- (void)kk_setupNavigationBar{
    [KKNavigationBarHelper.sharedInstance kk_updateConfigure:^(KKNavigationBarHelper *helper) {
        helper.kk_navItemRightSpace = CGFloatPixelRound(10.0);
        helper.kk_navItemLeftSpace  = CGFloatPixelRound(10.0);
        helper.kk_backStyle         = KKNavigationBarBackStyleBlack;
    }];
}


/**
 友盟配置
 */
- (void)setupUMeng{
#if   ENV_CODE == ENV_PROJECT
    
#elif ENV_CODE == ENV_PROJECT_OBJC
    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:true];
    [UMConfigure initWithAppkey:UMengKey channel:@"App Store"];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession|UMSocialPlatformType_WechatSession
//                                          appKey:weChatAppId
//                                       appSecret:weChatAppSecret
//                                     redirectURL:nil];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
//                                          appKey:QQAppKey
//                                       appSecret:QQAppSecret
//                                     redirectURL:nil];
#endif
}


/**
 配置云信SDK
 */
- (void) setupNIM{
    NIMSDKConfig *config          = [NIMSDKConfig sharedConfig];
    config.maxAutoLoginRetryTimes = 6;
    NIMServerSetting *settings    = [[NIMServerSetting alloc] init];
    settings.httpsEnabled         = true;
    [NIMSDK.sharedSDK setServerSetting:settings];
    NIMSDKOption *option = [NIMSDKOption optionWithAppKey:IM_AppKey];
    option.apnsCername   = @"";
    option.pkCername     = @"";
    [NIMSDK.sharedSDK registerWithOption:option];
}

/**
 配置主控制器
 */
- (void) setupMainVC{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor    = UIColor.whiteColor;
    self.window.rootViewController = KKLanuchViewController.alloc.init;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
