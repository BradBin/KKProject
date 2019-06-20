//
//  KKLoginViewModel.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/13.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKLoginViewModel : KKViewModel

@property (nonatomic, copy,readonly) NSString *account;
@property (nonatomic, copy,readonly) NSString *password;

@property (nonatomic,strong) RACCommand *loginCommand;
@property (nonatomic,strong) RACSubject *pushVCSubject;

@end

NS_ASSUME_NONNULL_END
