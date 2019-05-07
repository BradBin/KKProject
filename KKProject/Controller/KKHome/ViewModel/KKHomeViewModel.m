//
//  KKHomeViewModel.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/6.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeViewModel.h"

@implementation KKHomeViewModel

-(RACCommand *)categoryCommand{
    if (_categoryCommand == nil) {
        _categoryCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                return nil;
            }];
        }];
    }
    return _categoryCommand;
}

-(RACSubject *)categoryUISubject{
    if (_categoryUISubject == nil) {
        _categoryUISubject = RACSubject.subject;
    }
    return _categoryUISubject;
}

@end
