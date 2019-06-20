//
//  KKWebApi.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/20.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKWebApiProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKWebApi : NSObject

@property (nonatomic,  weak) id<KKWebApiProtocol>delegate;

@end

NS_ASSUME_NONNULL_END
