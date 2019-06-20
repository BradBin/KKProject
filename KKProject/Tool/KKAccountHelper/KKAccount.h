//
//  KKAccount.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/16.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKAccount : NSObject<NSCoding,NSCopying,NSMutableCopying>
@property (nonatomic,  copy) NSString *userName;
@property (nonatomic,  copy) NSString *userId;
@property (nonatomic,  copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
