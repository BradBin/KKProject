//
//  KKLanguageHelper.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 语言类型枚举
 */
typedef NS_ENUM(NSUInteger,KKLanguageType) {
    KKLanguageTypeDefault = 0, //伴随系统
    KKLanguageTypeEnglish,
    KKLanguageTypeChinese,     //简体中文
    KKLanguageTypeChinese_Hant,//繁体中文
};

//切换语言的通知消息Key
FOUNDATION_EXPORT NSString * const KKLanguageChangeKey;
//切换语言的通知消息
FOUNDATION_EXPORT NSString * const KKLanguageDidChangeNotification;

@interface KKLanguageHelper : NSObject

/**
 当前语言类型
 */
@property (nonatomic,assign,readonly) KKLanguageType languageType;
/**
 当前语言
 */
@property (nonatomic, copy,readonly) NSString   *language;

/**
 单例对象

 @return 单例对象
 */
+ (instancetype)shared;

/**
 设置语言类型

 @param languageType languageType
 */
- (void)setLanguage:(KKLanguageType)languageType;

@end

NS_ASSUME_NONNULL_END
