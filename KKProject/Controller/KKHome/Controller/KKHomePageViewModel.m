//
//  KKHomePageViewModel.m
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomePageViewModel.h"

@interface KKHomePageViewModel()
@property (nonatomic,assign) NSUInteger pageIndex;

@end
@implementation KKHomePageViewModel

-(void)kk_initialize{
    [super kk_initialize];
    [self kk_refreshUI];
}

- (void) kk_refreshUI{
    @weakify(self);
    [[self.refreshCommand.executionSignals.switchToLatest takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.refreshUISubject sendNext:nil];
    }];
    [[self.refreshCommand.errors takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self.refreshUISubject sendNext:@(KKRefreshDataStatusRefreshNetworkError)];
    }];
}

-(RACCommand *)refreshCommand{
    if (_refreshCommand == nil) {
        @weakify(self);
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.pageIndex = 1;
                [self kk_getHomeListWithSubscriber:subscriber];
                return nil;
            }];
        }];
    }
    return _refreshCommand;
}

-(RACCommand *)nextRefreshCommand{
    if (_nextRefreshCommand == nil) {
        @weakify(self);
        _nextRefreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                [self kk_getHomeListWithSubscriber:subscriber];
                return nil;
            }];
        }];
    }
    return _nextRefreshCommand;
}

- (void) kk_getHomeListWithSubscriber:(id<RACSubscriber>)subscriber{
    NSMutableDictionary *para = NSMutableDictionary.dictionary;
    [para setObject:self.categoryModel.type forKey:@"category"];
    [para setObject:kk_DEVICE_ID            forKey:@"device_id"];
    [para setObject:@"iphone"               forKey:@"device_platform"];
    [para setObject:KK_ACCOUNT_IID          forKey:@"iid"];
    [para setObject:@"6.2.7"                forKey:@"version_code"];
    [KKNetWorking kk_GetWithUrl:KK_Home_CATEGORY_LIST params:para requestHeader:nil success:^(NSURLResponse *response, id responseObject) {
        NSArray *array = [NSArray modelArrayWithClass:KKHomePageModel.class json:responseObject];
        [subscriber sendNext:array];
        [subscriber sendCompleted];
    } error:^(NSURLResponse *response, NSError *error) {
        [subscriber sendNext:error];
        [subscriber sendCompleted];
    } fail:^(NSError *error) {
        [subscriber sendError:error];
    }];
}

- (RACSubject *)refreshUISubject{
    if (_refreshUISubject == nil) {
        _refreshUISubject = RACSubject.subject;
    }
    return _refreshUISubject;
}

@end
