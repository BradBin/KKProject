//
//  KKErrorHelper.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKErrorHelper : NSObject


    
@end






UIKIT_EXTERN NSNotificationName KKHideLiveRoomNotificationName;
@interface KKErrorHelper(VCControl)
   
/**
 显示登陆VC
 */
+(void)kk_showLoginVC;
+(void)kk_showLoginVCWithMessage:(nullable NSString *)message;
 
+(void)kk_showHomeVC;

/**
 获取首次登陆需要显示的VC

 @return VC
 */
+(UIViewController *)kk_defaultVC;
    
@end

NS_ASSUME_NONNULL_END
