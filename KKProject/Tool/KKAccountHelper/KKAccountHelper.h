//
//  KKAccountHelper.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKAccount.h"

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
/** 用户账号 */
@property (nonatomic,  copy,readonly) NSString *userName;
/** 用户UserId */
@property (nonatomic,  copy,readonly) NSString *userId;
/** 用户信息模型 */
@property (nonatomic,strong,readonly) KKAccount *account;


/**
 管理工具对象

 @return 工具对象
 */
+ (instancetype)shared;


/**
 保存登录账号信息

 @param account 账号信息
 */
- (void)kk_saveAccountInfoWithAccount:(KKAccount *)account;

/**
 登陆
 */
- (void)kk_logIn;

/**
 退出登录
 */
- (void)kk_logOut;

@end

NS_ASSUME_NONNULL_END
