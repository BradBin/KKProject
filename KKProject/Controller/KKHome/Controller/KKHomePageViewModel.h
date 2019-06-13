//
//  KKHomePageViewModel.h
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewModel.h"
#import "KKHomeModel.h"
#import "KKHomePageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKHomePageViewModel : KKViewModel

/**
 类别模型
 */
@property (nonatomic,strong) KKHomeCategoryModel *categoryModel;

/**
 刷新
 */
@property (nonatomic,strong) RACCommand *refreshCommand;

/**
 加载更多
 */
@property (nonatomic,strong) RACCommand *nextRefreshCommand;

/**
 分页列表的数据源
 */
@property (nonatomic,strong) NSArray     *pageDatas;

/**
 刷新界面UI
 */
@property (nonatomic,strong) RACSubject  *refreshUISubject;

@end

NS_ASSUME_NONNULL_END
