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
@property (nonatomic,strong,readonly) TextLayout *titleLayout;
@property (nonatomic,strong,readonly) TextLayout *abstractLayout;
@property (nonatomic,strong,readonly) TextLayout *authorLayout;

@property (nonatomic,strong,readonly) KKHomeDataContentModel *content;

+ (instancetype)kk_layoutWithModel:(KKHomeDataContentModel *)content;

@end

NS_ASSUME_NONNULL_END
