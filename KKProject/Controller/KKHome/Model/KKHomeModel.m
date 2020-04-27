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
             @"share_info"   : KKHCTTShareInfoModel.class,
             @"filter_words" : KKHCTTFilterWordModel.class,
             @"middle_image" : KKHCTTImageModel.class,
             @"large_image"  : KKHCTTImageModel.class,
             @"large_image_list"   : KKHCTTImageModel.class,
             @"image_list"         : KKHCTTImageModel.class,
             @"thumb_image_list"   : KKHCTTImageModel.class,
             @"ugc_cut_image_list" : KKHCTTImageModel.class
             };
}

-(NSDate *)publish_date{
    NSTimeInterval time = (NSTimeInterval)self.publish_time.doubleValue;
    if (time) {
        return [NSDate dateWithTimeIntervalSince1970:time];
    }
    return nil;
}

-(KKHomeDataFileType)type{
    if (!self.has_image && (self.has_video || self.has_mp4_video || self.has_m3u8_video)) {
        return KKHomeDataFileTypeImage_Video;
    }else if (self.has_image && (!self.has_video || !self.has_mp4_video || !self.has_m3u8_video)){
        if (self.image_list.count >= 3) {
            return KKHomeDataFileTypeImage_Mutli;
        }else{
            return KKHomeDataFileTypeImage_Single;
        }
    }else{
        return KKHomeDataFileTypeImage_None;
    }
}
@end


@implementation KKHCTTFilterWordModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"Id"  : @"id"
             };
}
@end




@implementation KKImageUrlList
- (void)setUrl:(NSString *)url{
    _url = url ;
    if(![_url containsString:@"http:"] && ![_url containsString:@"https:"]){
        _url = [NSString stringWithFormat:@"http:%@",_url];
    }
    _url = [_url stringByReplacingOccurrencesOfString:@"\\" withString:@""];
}
@end

@implementation KKHCTTImageModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"url_list" : KKImageUrlList.class
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


@implementation KKHCTTShareInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"weixin_cover_image" : KKHCTTWeixinCoverImageModel.class
             };
}



@end


@implementation KKHCTTWeixinCoverImageModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"url_list" : KKImageUrlList.class
             };
}
@end
