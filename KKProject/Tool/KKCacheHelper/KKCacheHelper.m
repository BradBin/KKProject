//
//  KKCacheHelper.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKCacheHelper.h"

@interface KKCacheHelper ()
@property (nonatomic,assign) CGFloat imageCacheSize;

@end

@implementation KKCacheHelper

+ (instancetype)shared{
    static KKCacheHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
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



@end
