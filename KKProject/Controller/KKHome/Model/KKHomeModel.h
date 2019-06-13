//
//  KKHomeModel.h
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKModel.h"

NS_ASSUME_NONNULL_BEGIN
@class KKHomeCategoryModel;
@interface KKHomeModel : KKModel

@property (nonatomic,copy) NSString *version;
@property (nonatomic,strong) NSArray<KKHomeCategoryModel *> *categoryTitles;

@end



@interface KKHomeCategoryModel : KKModel

@property (nonatomic,  copy) NSString *category;
@property (nonatomic,  copy) NSString *concern_id;
@property (nonatomic,strong) NSNumber *default_add;
@property (nonatomic,assign) BOOL     flags;

@property (nonatomic,strong) NSURL    *icon_url;
@property (nonatomic,  copy) NSString *name;
@property (nonatomic,strong) NSNumber *tip_new;
@property (nonatomic,strong) NSNumber *type;
@property (nonatomic,strong) NSURL    *web_url;

@end

NS_ASSUME_NONNULL_END
