//
//  KKAccountHelper.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKAccountHelper.h"

static NSString *const kAlias           = @"Orange_KK";
static NSString *const kKeyChainService = @"KKProject";
static NSString *const kKeyChainAccount = @"KKProject.accountName";

@interface KKAccountHelper ()
@property (nonatomic, copy,) NSString *udid;
@end

@implementation KKAccountHelper
    
+(instancetype)shared{
    static KKAccountHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[KKAccountHelper alloc] init];
    });
    return _instance;
}
    

+(void)kk_logIn{
    
}

+(void)kk_logOut{
    
}
    

#pragma mark -
#pragma mark - private method

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
