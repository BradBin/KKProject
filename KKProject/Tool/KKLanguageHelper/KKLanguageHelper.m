//
//  KKLanguageHelper.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLanguageHelper.h"


NSString * const KKChinese     = @"zh-Hans";//简体中文
NSString * const KKChineseHant = @"zh-Hant";//繁体中文
NSString * const KKEnglish     = @"en";     //英文

NSString * const KKLocalizable  = @"Localizable";
NSString * const KKUserLanguage = @"userLanguage";

NSString * const KKLanguageChangeKey             = @"LanguageKey";
NSString * const KKLanguageDidChangeNotification = @"KK.Language.Did.Change.Notification";
@interface KKLanguageHelper()
@property (nonatomic,strong) NSBundle *bundle;
@property (nonatomic,assign) KKLanguageType languageType;

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

- (KKLanguageType)languageType{
    NSString *language = [self kk_language];
    if ([language containsString:KKChinese]) {
        return KKLanguageTypeChinese;
    }else if ([language containsString:KKChineseHant]){
        return KKLanguageTypeChinese_Hant;
    }else{
        return KKLanguageTypeEnglish;
    }
}

- (NSString *)language{
    return [self kk_language];
}

- (NSString *)kk_language{
    NSArray *languages     = [NSUserDefaults.standardUserDefaults objectForKey:@"AppleLanguages"];
    NSString *languageName = [NSString stringWithFormat:@"%@",languages.firstObject];
    return languageName;
}

- (void)setLanguage:(KKLanguageType)languageType{
    _languageType          = languageType;
    NSDictionary *userInfo = @{KKLanguageChangeKey:@(languageType)};
    [NSNotificationCenter.defaultCenter postNotificationName:KKLanguageDidChangeNotification object:nil userInfo:userInfo];
}

- (NSString *)languageFormatter:(NSString *)language{
    if([language rangeOfString:KKChinese].location != NSNotFound){
        return KKChinese;//简体中文
    }else if([language rangeOfString:KKChineseHant].location != NSNotFound){
        return KKChineseHant;//繁体中文
    }else{
        //字符串查找
        if([language rangeOfString:@"-"].location != NSNotFound) {
            //除了中文以外的其他语言统一处理@"ru_RU" @"ko_KR"取前面一部分
            NSArray *array = [language componentsSeparatedByString:@"-"];
            if (array.count > 1) {
                NSString *string = array[0];
                return string;
            }
        }
    }
    return language;
}


@end
