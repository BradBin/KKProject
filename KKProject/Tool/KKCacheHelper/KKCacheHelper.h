//
//  KKCacheHelper.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 缓存处理工具类
 */
@interface KKCacheHelper : NSObject

/**
 图片缓存大小
 */
@property (nonatomic,assign,readonly) CGFloat imageCacheSize;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 图片缓存单例

 @return 单例对象
 */
+ (instancetype)shared;


/***************YYImage的缓存处理**********************/

/**
 获取YYImage的图片缓存大小(单位:M)
 
 @return 图片缓存大小
 */
- (CGFloat)imageCache;

/**
清空YYImage的缓存

 @param progress 进度
 @param completion 完成后的回调block
 */
- (void)cleanImageCache:(void(^)(CGFloat progress,NSUInteger removedCount, NSUInteger totalCount))progress completion:(void(^)(BOOL error))completion;

@end

NS_ASSUME_NONNULL_END
