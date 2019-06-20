//
//  KKWebApiProtocol.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/20.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class KKWebApi;
@protocol KKWebApiProtocol <NSObject>

@optional

- (void)kk_errorHaveFonudWithWebApi:(KKWebApi *)webApi error:(NSError *)error;

@end
