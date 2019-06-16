//
//  KKErrorHelper.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,KKNetErrorCode)  {
    KKNetErrorCodeSuccess = 200, //请求成功
    KKNetErrorCodeRelogin = 250, // Token 校验失败 需重新登录
    
    //    KKNetErrorCodeErrorTokenCheckFailure = 10101, // 验证失败
    //    KKNetErrorCodeErrorTokenNotExist     = 10103, // token not find
    KKNetErrorCodeErrorTokenExpired      = 90002, // token 过期
    //    KKNetErrorCodeErrorTokenInvalid      = 10406, // token 无效
    //    KKNetErrorCodeUserNotLogin           = 10227, // 用户未登录
    KKNetErrorCodeUserInvalid            = 90001, // 用户被禁用
    //    KKNetErrorCodeUserExisted            = 10201, // 用户已存在
    //    KKNetErrorCodeUserNotExist           = 10202, // 用户不存在
    
    //    KKNetErrorCodeDiffentPWD             = 10222, // 两次密码不一致
    
    KKNetErrorCodeNormalERROR            = 99999,
};


@interface KKError : NSError

@property (nonatomic, assign) KKNetErrorCode errorCode;
@property (nonatomic, assign) NSInteger errorCodeValue;
@property (nonatomic, copy  ) NSString *desc;
@property (nonatomic, strong) id info;

- (BOOL)kk_isReloginError;

@end



@interface KKErrorHelper : NSObject

+ (KKError *)kk_errorWithInfo:(id)errorInfo;
+ (KKError *)kk_errorWithDesc:(NSString *)desc;
    
@end



UIKIT_EXTERN NSNotificationName KKHideLiveRoomNotificationName;
typedef void(^ _Nullable KKVCBlock)(UIViewController *vc);
@interface KKErrorHelper(VCControl)

/********************界面UI的相关部分**********************/
/**
显示登陆VC
*/
+ (void)kk_showLoginVC;
+ (void)kk_showLoginVCWithBlock:(KKVCBlock)block;

+ (void)kk_showHomeVC;
+ (void)kk_showHomeVCWithBlock:(KKVCBlock)block;


/**
 获取首次登陆需要显示的VC

 @return VC
 */
+(UIViewController *)kk_defaultVC;

/**
 进入App
 */
+ (void)kk_enterApp;


    
@end

NS_ASSUME_NONNULL_END
