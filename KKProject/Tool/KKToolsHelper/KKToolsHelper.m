//
//  KKToolsHelper.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/27.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKToolsHelper.h"

@implementation KKToolsHelper

+ (instancetype)shared{
    static KKToolsHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

- (NSString *)timelineWithDate:(NSDate *)date{
    if (date == nil) return @"";
    static NSDateFormatter *formatterYesterday = nil;
    static NSDateFormatter *formatterSameYear  = nil;
    static NSDateFormatter *formatterFullDate   = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    if (delta < -60 * 10) { // 本地时间有问题
        return [formatterFullDate stringFromDate:date];
    } else if (delta < 60 * 10) { // 10分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%ld分钟前", (long)(delta / 60.0)];
    } else if (date.isToday) {
        return [NSString stringWithFormat:@"%ld小时前", (long)(delta / 60.0 / 60.0)];
    } else if (date.isYesterday) {
        return [formatterYesterday stringFromDate:date];
    } else if (date.year == now.year) {
        return [formatterSameYear stringFromDate:date];
    } else {
        return [formatterFullDate stringFromDate:date];
    }
}


-(void)htmlStringWithURL:(NSURL *)url completion:(void (^)(NSString * _Nullable, NSError * _Nullable))completion{
    
    if (!url && url.absoluteString.isNotBlank == false) {
        NSError *error = NSError.alloc.init;
        if (completion) completion(nil,error);
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    __weak __typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data.length) {
              __strong __typeof(weakSelf) strongSelf = weakSelf;
            NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSString *htmlString = [strongSelf pasrseNewsDetail:dataString];
            if(!htmlString.length){
                htmlString = [strongSelf pasrseNewsDetail2:dataString];
            }
            if(!htmlString.length){
                htmlString = [strongSelf pasrseNewsDetail3:dataString];
            }
            if (completion) {
                completion(htmlString,error);
            }
            
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];
    [task resume];
}


//-(void)imageWithURL:(NSURL *)url completion:(void (^)(NSArray<UIImage *> * _Nullable, NSError * _Nullable))completion{
//    
//    if (!url && url.absoluteString.isNotBlank == false) {
//        NSError *error = NSError.alloc.init;
//        if (completion) completion(nil,error);
//        return;
//    }
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
//    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error == nil && data.length) {
//         
//            NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSArray<KKImageItem *> *array = [self pasrseGallary:dataStr];
//            if(completion){
//                completion(array);
//            }
//            
//            
//        }else{
//            if (completion) {
//                completion(nil,error);
//            }
//        }
//    }];
//    [task resume];
//}





















//一般格式的新闻
- (NSString *)pasrseNewsDetail:(NSString *)newsContent{
    if(!newsContent.length){
        return @"";
    }
    
    NSString *rstString = [newsContent copy];
    NSString *lt = @"&lt;";
    NSString *gt = @"&gt;";
    NSString *qout = @"&quot;";
    
    NSRange range = [rstString rangeOfString:@"articleInfo"];
    if(range.location == NSNotFound){
        return @"";
    }
    rstString = [rstString substringFromIndex:range.location + range.length];
    
    range = [rstString rangeOfString:@"content"];
    if(range.location == NSNotFound){
        return @"";
    }
    rstString = [rstString substringFromIndex:range.location + range.length];
    
    range = [rstString rangeOfString:@"'"];
    if(range.location == NSNotFound){
        return @"";
    }
    rstString = [rstString substringFromIndex:range.location + range.length];
    
    range = [rstString rangeOfString:@"'"];
    if(range.location == NSNotFound){
        return @"";
    }
    rstString = [rstString substringToIndex:range.location];
    
    rstString = [rstString stringByReplacingOccurrencesOfString:lt withString:@"<"];
    rstString = [rstString stringByReplacingOccurrencesOfString:gt withString:@">"];
    rstString = [rstString stringByReplacingOccurrencesOfString:qout withString:@"\""];
    
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:18px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            "$img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>",rstString];
    
    return htmlString;
}

- (NSString *)pasrseNewsDetail2:(NSString *)newsContent{
    if(!newsContent.length){
        return @"";
    }
    
    NSString *rstString = [newsContent copy];
    NSString *lt = @"&lt;";
    NSString *gt = @"&gt;";
    NSString *qout = @"&quot;";
    
    NSRange range = [rstString rangeOfString:@"<article>"];
    if(range.location == NSNotFound){
        return @"";
    }
    rstString = [rstString substringFromIndex:range.location + range.length];
    
    range = [rstString rangeOfString:@"</article>"];
    if(range.location == NSNotFound){
        return @"";
    }
    rstString = [rstString substringToIndex:range.location];
    
    rstString = [rstString stringByReplacingOccurrencesOfString:lt withString:@"<"];
    rstString = [rstString stringByReplacingOccurrencesOfString:gt withString:@">"];
    rstString = [rstString stringByReplacingOccurrencesOfString:qout withString:@"\""];
    
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:18px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            "$img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>",rstString];
    
    return htmlString;
}

//兼容环球时报
- (NSString *)pasrseNewsDetail3:(NSString *)newsContent{
    if(!newsContent.length){
        return @"";
    }
    
    NSString *rstString = [newsContent copy];
    NSString *lt = @"&lt;";
    NSString *gt = @"&gt;";
    NSString *qout = @"&quot;";
    
    NSRange range = [rstString rangeOfString:@"<!-- 信息区 end -->"];
    if(range.location == NSNotFound){
        return @"";
    }
    rstString = [rstString substringFromIndex:range.location + range.length];
    
    range = [rstString rangeOfString:@"<!--正文结束-->"];
    if(range.location == NSNotFound){
        return @"";
    }
    rstString = [rstString substringToIndex:range.location];
    
    rstString = [rstString stringByReplacingOccurrencesOfString:lt withString:@"<"];
    rstString = [rstString stringByReplacingOccurrencesOfString:gt withString:@">"];
    rstString = [rstString stringByReplacingOccurrencesOfString:qout withString:@"\""];
    
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:18px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            "$img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>",rstString];
    
    return htmlString;
}


@end
