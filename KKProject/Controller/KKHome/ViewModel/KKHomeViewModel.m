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

-(RACSubject *)refreshCategoryBackUISubject{
    if (_refreshCategoryBackUISubject == nil) {
        _refreshCategoryBackUISubject = RACSubject.subject;
    }
    return _refreshCategoryBackUISubject;
}

-(RACSubject *)pushVCSubject{
    if (_pushVCSubject == nil) {
        _pushVCSubject = RACSubject.subject;
    }
    return _pushVCSubject;
}

-(RACSubject *)presentVCSubject{
    if (_presentVCSubject == nil) {
        _presentVCSubject = RACSubject.subject;
    }
    return _presentVCSubject;
}

@end




NSUInteger const kk_home_page_pageSize = 15;
@interface KKHomePageViewModel()
@property (nonatomic,assign) NSUInteger pageIndex;
@property (nonatomic,strong) NSArray   *footerArray;

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
        if ([x isKindOfClass:KKError.class]) {
            [self.refreshUISubject sendNext:@(KKRefreshStatusNetworkError_Header)];
        }else{
            if ([x isKindOfClass:NSArray.class]) {
                [self.homeLayouts insertObjects:(NSArray<KKHomeLayout *> *)x atIndex:0];
                if ([x count] <= kk_home_page_pageSize) {
                    [self.refreshUISubject sendNext:@(KKRefreshStatusNoMoreData_Header)];
                }else{
                    [self.refreshUISubject sendNext:@(KKRefreshStatusMoreData_Header)];
                }
            }else{
                [self.refreshUISubject sendNext:@(KKRefreshStatusDataUnexpect_Header)];
            }
        }
    }];
    [[self.refreshCommand.errors takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self.refreshUISubject sendNext:@(KKRefreshStatusNetworkError_Header)];
    }];
    
    [[self.nextRefreshCommand.executionSignals.switchToLatest takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:KKError.class]) {
            [self.refreshUISubject sendNext:@(KKRefreshStatusNetworkError_Header)];
        }else{
            if ([x isKindOfClass:NSArray.class]) {
                [self.homeLayouts addObjectsFromArray:(NSArray<KKHomeLayout *> *)x];
                if ([x count] <= kk_home_page_pageSize) {
                    [self.refreshUISubject sendNext:@(KKRefreshStatusNoMoreData_Footer)];
                }else{
                    [self.refreshUISubject sendNext:@(KKRefreshStatusMoreData_Footer)];
                }
            }else{
                [self.refreshUISubject sendNext:@(KKRefreshStatusDataUnexpect_Footer)];
            }
        }
    }];
    
    [[self.nextRefreshCommand.errors  takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self.refreshUISubject sendNext:@(KKRefreshStatusNetworkError_Footer)];
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
        NSArray<KKHomeContentModel *> *array = [NSArray modelArrayWithClass:KKHomePageModel.class json:responseObject];
        NSMutableArray *layouts = NSMutableArray.array;
        [array enumerateObjectsUsingBlock:^(KKHomeContentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KKHomeLayout *layout = [KKHomeLayout kk_layoutWithModel:obj];
            [layouts addObject:layout];
        }];
        [subscriber sendNext:layouts];
        [subscriber sendCompleted];
    } error:^(NSURLResponse *response, NSError *error) {
        [subscriber sendNext:error];
        [subscriber sendCompleted];
    } fail:^(NSError *error) {
        [subscriber sendError:error];
    }];
}

-(NSMutableArray<KKHomeLayout *> *)homeLayouts{
    if (_homeLayouts == nil) {
        _homeLayouts = NSMutableArray.array;
    }
    return _homeLayouts;
}

- (RACSubject *)refreshUISubject{
    if (_refreshUISubject == nil) {
        _refreshUISubject = RACSubject.subject;
    }
    return _refreshUISubject;
}

@end
