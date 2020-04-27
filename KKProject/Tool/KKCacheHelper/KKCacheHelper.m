//
//  KKCacheHelper.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKCacheHelper.h"

@interface KKCacheHelper ()
@property (nonatomic,assign) CGFloat              imageCacheSize;
@property (nonatomic,strong) NSMutableDictionary *cacheKeyDictionary;
@property (nonatomic,strong) YYDiskCache         *diskCache;
@end

@implementation KKCacheHelper

- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true) firstObject];
        NSString *path  = [cacheFolder stringByAppendingPathComponent:name];
        _diskCache = [[YYDiskCache alloc] initWithPath:path];
        _cacheKeyDictionary = NSMutableDictionary.dictionary;
    }
    return self;
}

+ (instancetype)shared{
    static KKCacheHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] initWithName:@"kkCache"];
    });
    return _instance;
}

- (CGFloat)imageCacheSize{
    return [self imageCache];
}

- (CGFloat)imageCache{
    YYImageCache  *cache = YYWebImageManager.sharedManager.cache;
    CGFloat cacheSize    = 1.00f * cache.diskCache.totalCost / 1024 /1024;
    return cacheSize;
}

- (void)cleanImageCache:(void(^)(CGFloat progress,NSUInteger removedCount, NSUInteger totalCount))progress completion:(void(^)(BOOL error))completion{
    YYImageCache  *cache = YYWebImageManager.sharedManager.cache;
    [cache.diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        if (progress) {
            dispatch_async_on_main_queue(^{
               progress(1.0f * removedCount/totalCount,removedCount,totalCount);
            });
        }
    } endBlock:^(BOOL error) {
        if (completion) {
            dispatch_async_on_main_queue(^{
                completion(error);
            });
        }
    }];
}



/**************将数据保存在Disk上的缓存处理**********************/

-(void)setObject:(id<NSCoding>)objects forKey:(NSString *)key withBlock:(void (^)(void))block{
    if (self.cacheKeyDictionary[key]) {
        objects =  [self trimArray:(NSArray *)objects toTargetCount:[self.cacheKeyDictionary[key] integerValue]];
    }
    [self.diskCache setObject:objects forKey:key withBlock:block];
}

-(id<NSCoding>)objectFromDiskWithKey:(NSString *)key{
    return [self.diskCache objectForKey:key];
}

-(void)objectFromDiskWithKey:(NSString *)key withBlock:(void (^)(NSString * _Nonnull, id<NSCoding> _Nonnull))block{
    [self.diskCache objectForKey:key withBlock:block];
}

- (void)removeObjectFromDiskWithKey:(NSString *)key{
    [self.diskCache removeObjectForKey:key];
}


- (void)setMaxCount:(NSUInteger)maxCount forKey:(NSString *)key{
    self.cacheKeyDictionary[key] = @(maxCount);
}

- (void)removeMaxCountForKey:(NSString *)key{
    [self.cacheKeyDictionary removeObjectForKey:key];
}

#pragma mark -
#pragma mark - private method
/**
 保存缓存的数据,超过最大数据数量时,保存最新的数据

 @param datas 待缓存的数据
 @param count 最大的数据
 @return 保存的数据
 */
- (id<NSCoding>)trimArray:(NSArray *)datas toTargetCount:(NSUInteger)count{
    count = count > 0 ? count : 0 ;
    if (datas.count <= count) {
        return datas;
    }
    NSUInteger beginCount = datas.count - count;
    NSMutableArray *newDatas = NSMutableArray.array;
    for (NSUInteger i = beginCount ; i < datas.count; i ++) {
        [newDatas addObject:datas[i]];
    }
    return newDatas;
}

@end
