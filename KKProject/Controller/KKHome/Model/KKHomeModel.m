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
