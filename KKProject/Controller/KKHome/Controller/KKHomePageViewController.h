//
//  KKHomePageViewController.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/6.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewController.h"
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN
@class KKHomeCategoryModel;
@interface KKHomePageViewController : KKViewController<JXCategoryListContentViewDelegate>
@property (nonatomic,strong) KKHomeCategoryModel *categoryModel;

@end

NS_ASSUME_NONNULL_END
