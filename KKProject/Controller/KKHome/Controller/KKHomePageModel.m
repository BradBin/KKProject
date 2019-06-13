//
//  KKHomePageModel.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomePageModel.h"

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
