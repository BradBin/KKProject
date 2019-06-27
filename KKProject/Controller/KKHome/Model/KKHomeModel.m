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
             @"categoryTitles" : KKHomeCategoryTitleModel.class
             };
}

@end


@implementation KKHomeCategoryTitleModel

@end




@implementation KKHomeCategoryContentModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : KKHomeDataModel.class,
             @"tips" : KKHomeTipsModel.class
             };
}

@end




@implementation KKHomeTipsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"appName"         : @"app_name",
             @"displayDuration" : @"display_duration",
             @"displayInfo"     : @"display_info",
             @"displayTemplate" : @"display_template",
             
             @"downloadUrl"     : @"download_url",
             @"openUrl"         : @"open_url",
             @"packageName"     : @"package_name",
             @"webUrl"          : @"web_url",
             };
}

@end



@implementation KKHomeDataModel
-(KKHomeDataContentModel *)contentModel{
    KKHomeDataContentModel *model = [KKHomeDataContentModel modelWithJSON:self.content];
    return model;
}

@end


@implementation KKHomeDataContentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"filter_words" : KKHCTTFilterWordModel.class
             };
}


-(NSDate *)publish_date{
    NSTimeInterval time = (NSTimeInterval)self.publish_time.doubleValue;
    if (time) {
        return [NSDate dateWithTimeIntervalSince1970:time];
    }
    return nil;
}

-(KKContentSourceType)sourceType{
    NSUInteger type = self.source_icon_style.unsignedIntegerValue;
    switch (type) {
        case 1:
            break;
            
        case 2:
            break;
            
        case 3:
            break;
            
        case 4:
            break;
            
        case 5:
            break;
            
        case 6:
            return KKContentSourceTypeKeynNote;
            break;
            
        default:
            return KKContentSourceTypeDefault;
            break;
    }
    return KKContentSourceTypeDefault;
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
