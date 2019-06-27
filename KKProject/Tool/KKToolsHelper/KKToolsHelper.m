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


@end
