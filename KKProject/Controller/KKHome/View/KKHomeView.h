//
//  KKHomeView.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/19.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTableView.h"
#import <JXCategoryView/JXCategoryView.h>
#import "KKHomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKHomeView : KKTableView<JXCategoryListContentViewDelegate>
@property (nonatomic,strong) KKHomeCategoryTitleModel *categoryModel;

@end

NS_ASSUME_NONNULL_END
