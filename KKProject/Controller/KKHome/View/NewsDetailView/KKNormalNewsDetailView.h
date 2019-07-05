//
//  KKNormalNewsDetailView.h
//  KKProject
//
//  Created by 尤彬 on 2019/7/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDragableNavigationView.h"

NS_ASSUME_NONNULL_BEGIN
@class KKHomeDataContentModel;
@interface KKNormalNewsDetailView : KKDragableNavigationView

- (instancetype)initWithContentModel:(KKHomeDataContentModel *)contentModel;

@end

NS_ASSUME_NONNULL_END
