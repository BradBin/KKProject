//
//  KKHomeLayout.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLayout.h"
#import "KKHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKHomeLayout : KKLayout
@property (nonatomic,assign,readonly) CGFloat height;

+ (instancetype)kk_layoutWithModel:(KKHomeContentModel *)model;

@end

NS_ASSUME_NONNULL_END
