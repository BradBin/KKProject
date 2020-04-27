//
//  KKThemeHelper.m
//  KKProject
//
//  Created by youbin on 2020/1/21.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKThemeHelper.h"
#import "AppDelegate.h"

@implementation KKThemeHelper

+(instancetype)shared{
    static KKThemeHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

-(void)setAlternateIcon:(NSString *)alternateIconName completionHandler:(void (^)(NSError * _Nullable))completionHandler{
    UIApplication *app = UIApplication.sharedApplication;
    /// 判断设备的系统版本是否支持更换App Logo
    if (app.supportsAlternateIcons) {
        alternateIconName = [alternateIconName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        /// 更换的App Logo的名称是否存在
        if (!alternateIconName.length) {
            NSError *error = [NSError errorWithDomain:NSMachErrorDomain code:10211 userInfo:@{NSLocalizedDescriptionKey:@"alternateIconName不能为空"}];
            if (completionHandler) {
                completionHandler(error);
            }
        }else{
            UIImage *image = [UIImage imageNamed:alternateIconName];
            /// 更换的App Logo的图片是否存在
            if (!image) {
                NSError *error = [NSError errorWithDomain:NSMachErrorDomain code:10212 userInfo:@{NSLocalizedDescriptionKey:@"alternateIcon图片不能为空"}];
                if (completionHandler) {
                    completionHandler(error);
                }
            }else{
                /// 更换App Logo
                if (NSThread.currentThread.isMainThread) {
                    [app setAlternateIconName:alternateIconName completionHandler:completionHandler];
                }else{
                    dispatch_async_on_main_queue(^{
                        [app setAlternateIconName:alternateIconName completionHandler:completionHandler];
                    });
                }
            }
        }
    }else{
        NSError *error = [NSError errorWithDomain:NSMachErrorDomain code:10213 userInfo:@{NSLocalizedDescriptionKey:@"设备当前系统版本不支持"}];
        if (completionHandler) {
            completionHandler(error);
        }
    }
}

@end
