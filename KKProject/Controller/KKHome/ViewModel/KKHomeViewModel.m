//
//  KKHomeViewModel.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/6.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeViewModel.h"

@implementation KKHomeViewModel

-(void)kk_initialize{
    [super kk_initialize];
    [self kk_getCategoryTitles];
}

/**
 获取类型标题数据
 */
- (void) kk_getCategoryTitles{
   
    @weakify(self);
    [[self.categoryCommand.executionSignals.switchToLatest takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:KKHomeModel.class]) {
            KKHomeModel *home = (KKHomeModel *)x;
            if (home.categoryTitles.count) {
                self.categoryTitles = [NSArray arrayWithArray:home.categoryTitles];
                [self.categoryUISubject sendNext:home.categoryTitles];
            }else{
                //数据异常处理
            }
        }else{
           //数据异常处理
        }
    }];
    [[self.categoryCommand.errors takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self.categoryUISubject sendNext:(NSError *)x];
    }];
    [[self.categoryCommand.executing takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        [self.categoryUISubject sendNext:x];
    }];
     [self.categoryCommand execute:@(13)];
}


-(RACCommand *)categoryCommand{
    if (_categoryCommand == nil) {
        _categoryCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSMutableDictionary *para = NSMutableDictionary.dictionary;
                [para setObject:kk_DEVICE_ID   forKey:@"device_id"];
                [para setObject:KK_ACCOUNT_IID forKey:@"iid"];
                [para setObject:@(13)          forKey:@"aid"];
                [KKNetWorking kk_GetWithUrl:KK_CATEGORY_TITLE params:para requestHeader:nil success:^(NSURLResponse *response, id responseObject) {
                    KKHomeModel *model = [KKHomeModel modelWithJSON:responseObject];
                    [subscriber sendNext:model];
                    [subscriber sendCompleted];
                } error:^(NSURLResponse *response, NSError *error) {
                    [subscriber sendNext:error];
                    [subscriber sendCompleted];
                } fail:^(NSError *error) {
                    [subscriber sendError:error];
                }];
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
