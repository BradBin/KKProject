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


/**************图片YYImage的缓存处理**********************/

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




/**************将数据保存在Disk上的缓存处理**********************/

/**
 保存数据(数组)到本地Disk

 @param objects 数据(数组)
 @param key key
 @param block 保存完成后执行的block
 */
- (void)setObject:(NSArray<id<NSCoding>> *)objects forKey:(nonnull NSString *)key withBlock:(void(^_Nullable)(void))block;

/**
 通过key获取本地Disk上缓存的数据

 @param key key
 @return 缓存的数据
 */
- (id<NSCoding>)objectFromDiskWithKey:(NSString *)key;

- (void)objectFromDiskWithKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> object))block;

/**
 通过key删除本地缓存的数据

 @param key key
 */
- (void)removeObjectFromDiskWithKey:(nonnull NSString *)key;

/**
 设置本地缓存数据的数量

 @param maxCount 缓存的最大数量
 @param key key
 */
- (void)setMaxCount:(NSUInteger)maxCount forKey:(nonnull NSString *)key;

/**
 删除本地缓存数量的最大数量限制

 @param key key
 */
- (void)removeMaxCountForKey:(nonnull NSString *)key;


@end

NS_ASSUME_NONNULL_END
