//
//  KKHomeModel.m
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeModel.h"

@implementation KKHomeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"categoryTitles"  : @"data"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"categoryTitles" : KKHomeCategoryModel.class
             };
}

@end


@implementation KKHomeCategoryModel

@end






@implementation KKHomePageModel

-(KKHomeContentModel *)contentModel{
    KKHomeContentModel *model = [KKHomeContentModel modelWithJSON:self.content];
    return model;
}

@end


@implementation KKHomeContentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"filter_words" : KKHCTTFilterWordModel.class
             };
}

@end


@implementation KKHCTTFilterWordModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"Id"  : @"id"
             };
}

@end




@implementation KKHCTTUserInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"desc"  : @"description"
             };
}

@end
