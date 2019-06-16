//
//  KKLoginViewModel.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/13.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLoginViewModel.h"

@implementation KKLoginViewModel

-(void)kk_initialize{
    [super kk_initialize];
}

-(RACCommand *)loginCommand{
    if (_loginCommand == nil) {
        @weakify(self);
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                if (self.account.length > 3 && self.password.length > 3) {
                    
                    NSDictionary *dict = @{
                                           @"userName":ACCOUNT,
                                           @"password":PASSWORD
                                           };
                    
                    KKAccount *account = [KKAccount modelWithJSON:dict];
                    [KKAccountHelper.shared kk_saveAccountInfoWithAccount:account];
                    [subscriber sendNext:@"success"];
                    [subscriber sendCompleted];
                }else{
                    KKError *error = [KKErrorHelper kk_errorWithDesc:@"failure"];
                    [subscriber sendError:error];
                }
                return nil;
            }];
        }];
    }
    return _loginCommand;
}

-(RACSubject *)pushVCSubject{
    if (_pushVCSubject == nil) {
        _pushVCSubject = RACSubject.subject;
    }
    return _pushVCSubject;
}

@end
