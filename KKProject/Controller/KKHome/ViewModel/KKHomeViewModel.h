//
//  KKHomeViewModel.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/6.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewModel.h"
#import "KKHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKHomeViewModel : KKViewModel

/**
 获取类型标题
 */
@property (nonatomic,strong) RACCommand *categoryCommand;

/**
 获取类型标题后执行刷新UI的信号
 */
@property (nonatomic,strong) RACSubject *categoryUISubject;

/**
 获取类型标题数据源
 */
@property (nonatomic,strong) NSArray<KKHomeCategoryModel *> *categoryTitles;

@end

NS_ASSUME_NONNULL_END
