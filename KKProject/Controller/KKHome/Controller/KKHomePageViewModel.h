//
//  KKHomePageViewModel.h
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewModel.h"
#import "KKHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKHomePageViewModel : KKViewModel
@property (nonatomic,strong) KKHomeCategoryModel *categoryModel;

/**
 分页列表的数据源
 */
@property (nonatomic,strong) NSArray             *pageDatas;

@end

NS_ASSUME_NONNULL_END
