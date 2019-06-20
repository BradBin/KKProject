//
//  KKWebViewController.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/20.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewController.h"
#import "KKWebApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKWebViewController : KKViewController
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithURLString:(nonnull NSString *)URLString webApis:(nullable NSArray<KKWebApi *> *)webApis;

@end

NS_ASSUME_NONNULL_END
