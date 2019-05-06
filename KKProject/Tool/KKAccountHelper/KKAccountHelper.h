//
//  KKAccountHelper.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKAccountHelper : NSObject
/** 用户登陆设备的UDID */
@property (nonatomic,  copy,readonly) NSString *udid;
/** 是否登录  登录:true 反之,则否*/
@property (nonatomic,assign,readonly) BOOL isLogin;
/** 登录是否过期 登录过期:true 反之,则否*/
@property (nonatomic,assign,readonly) BOOL isExpired;
/** 用户token */
@property (nonatomic,  copy,readonly) NSString *token;


+(instancetype)shared;
/**
 登陆
 */
+(void)kk_logIn;

/**
 退出登录
 */
+(void)kk_logOut;
@end

NS_ASSUME_NONNULL_END
