//
//  KKAccountHelper.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKAccountHelper.h"
#import <NIMSDK/NIMSDK.h>

static NSString *const kAlias           = @"Orange_KK";
static NSString *const kKeyChainService = @"KKProject";
static NSString *const kKeyChainAccount = @"KKProject.accountName";

@interface KKAccountHelper ()
@property (nonatomic,  copy) NSString *udid;
@property (nonatomic,  copy) NSString *userName;
@property (nonatomic,  copy) NSString *passoword;
@property (nonatomic,  copy) NSString *userId;
@property (nonatomic,strong) KKAccount *account;
@end

@implementation KKAccountHelper

+ (instancetype)shared{
    static KKAccountHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[KKAccountHelper alloc] init];
        KKAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[_instance kk_accountInfoPath]];
        if (!account || ![account isKindOfClass:[KKAccount class]]) {
            account = [[KKAccount alloc] init];
        }
        _instance.account = account;
    });
    return _instance;
}

-(BOOL)isLogin{
    BOOL result = self.userName.isNotBlank && self.passoword;
    return result;
}

-(BOOL)isExpired{
    return false;
}

-(NSString *)userName{
    return self.account.userName;
}

-(NSString *)passoword{
    return self.account.password;
}

-(NSString *)userId{
    return self.account.userId;
}

-(void)kk_saveAccountInfoWithAccount:(KKAccount *)account{
    _account = account;
    BOOL result = [NSKeyedArchiver archiveRootObject:account toFile:[self kk_accountInfoPath]];
    NSLog(@"用户账号保存:%@",result?@"成功":@"失败");
}


- (void)kk_logIn{
    [NIMSDK.sharedSDK.loginManager login:self.userName token:self.passoword completion:^(NSError * _Nullable error) {
        NSLog(@"网易云信登录:%@",error?error.localizedDescription:@"成功");
    }];
    
}

-(void)kk_logOut{
    [NIMSDK.sharedSDK.loginManager logout:^(NSError * _Nullable error) {
        NSLog(@"网易云信退出:%@",error?error.localizedDescription:@"成功");
    }];
}


#pragma mark -
#pragma mark - private method

/**
 保存重新获取的用户模型的位置路径
 */
- (NSString *)kk_accountInfoPath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountInfo.archive"];
}

/**
 获取设备存储d钥匙串的UDID
 
 @return UDID
 */
-(NSString *)udid{
    if (_udid == nil) {
        NSString *udid = [YYKeychain getPasswordForService:kKeyChainService account:kKeyChainAccount];
        if (udid.isNotBlank == false) {
            udid = [NSString stringWithUUID];
            [YYKeychain setPassword:udid forService:kKeyChainService account:kKeyChainAccount];
        }
        _udid = udid;
    }
    return _udid;
}

@end
