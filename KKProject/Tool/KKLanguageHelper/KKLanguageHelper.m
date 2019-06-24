//
//  KKLanguageHelper.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLanguageHelper.h"

NSString * const KKLocalizable  = @"Localizable";
NSString * const KKUserLanguage = @"userLanguage";

@interface KKLanguageHelper()
@property (nonatomic,strong) NSBundle *bundle;

@end

@implementation KKLanguageHelper

+ (instancetype)shared{
    static KKLanguageHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}


- (NSString *)currentLanguage{
    return [NSUserDefaults.standardUserDefaults objectForKey:KKUserLanguage];
}

- (NSString *)languageFormatter:(NSString *)language{
    if([language rangeOfString:@"zh-Hans"].location != NSNotFound){
        return @"zh-Hans";
    }else if([language rangeOfString:@"zh-Hant"].location != NSNotFound){
        return @"zh-Hant";
    }else{
        //字符串查找
        if([language rangeOfString:@"-"].location != NSNotFound) {
            //除了中文以外的其他语言统一处理@"ru_RU" @"ko_KR"取前面一部分
            NSArray *ary = [language componentsSeparatedByString:@"-"];
            if (ary.count > 1) {
                NSString *str = ary[0];
                return str;
            }
        }
    }
    return language;
}


@end
