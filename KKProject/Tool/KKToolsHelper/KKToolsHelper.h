//
//  KKToolsHelper.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/27.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKToolsHelper : NSObject

+ (instancetype)shared;

/**
 日期date转成友好显示
 for example:刚刚 1分钟前 昨天 ...
 
 @param date NSDate
 @return NSString
 */
- (NSString *)timelineWithDate:(NSDate *)date;


/**
 对网络文章的url进一步解析,获取新闻的正文

 @param url 网络正文的url
 @param completion 解析完成后的block
 */
- (void)htmlStringWithURL:(NSURL *)url completion:(void(^)(NSString * _Nullable htmlString,NSError * _Nullable error))completion;

//- (void)imageWithURL:(NSURL *)url completion:(void (^)(NSArray<UIImage *> * _Nullable images, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
