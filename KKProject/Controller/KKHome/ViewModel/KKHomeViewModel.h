//
//  KKHomeViewModel.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/6.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewModel.h"
#import "KKHomeLayout.h"
#import "KKHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class KKHomePageViewModel;
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
@property (nonatomic,strong) NSArray<KKHomeCategoryTitleModel *> *categoryTitles;

/**
 刷新category的背景UI
 */
@property (nonatomic,strong) RACSubject *refreshCategoryBackUISubject;

/**
 push VC
 */
@property (nonatomic,strong) RACSubject *pushVCSubject;

/**
 present VC
 */
@property (nonatomic,strong) RACSubject *presentVCSubject;

@end




@interface KKHomePageViewModel : KKViewModel

/**
 类别模型
 */
@property (nonatomic,strong) KKHomeCategoryTitleModel *categoryModel;

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
@property (nonatomic,strong) NSMutableArray<KKHomeLayout *> *homeLayouts;

/**
 刷新界面UI
 */
@property (nonatomic,strong) RACSubject  *refreshUISubject;

@end



/**
 新闻类请求详情ViewModel
 */
@interface KKHomeDetailViewModel : KKViewModel

/**
 新闻类简介Model
 */
@property (nonatomic,strong) KKHomeDataContentModel *contentModel;

/**
 刷新
 */
@property (nonatomic,strong) RACCommand *refreshCommand;

/**
 加载更多
 */
@property (nonatomic,strong) RACCommand *nextRefreshCommand;

/**
 刷新界面UI
 */
@property (nonatomic,strong) RACSubject  *refreshUISubject;



@end




NS_ASSUME_NONNULL_END
