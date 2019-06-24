//
//  KKLanguageHelper.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKLanguageHelper : NSObject

@property (nonatomic, copy,readonly) NSString *currentLanguage;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
