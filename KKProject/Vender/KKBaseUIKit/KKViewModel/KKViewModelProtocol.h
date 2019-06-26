//
//  KKViewModelProtocol.h
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/10/25.
//  Copyright © 2018 youbin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络刷新状态
 */
typedef NS_ENUM(NSUInteger,KKRefreshStatus) {
    KKRefreshStatusRefreshUI = 0,//刷新UI
    KKRefreshStatusNoData, //暂无数据
    
    KKRefreshStatusDataUnexpect, //数据异常
    KKRefreshStatusDataUnexpect_Header, //数据异常_下拉刷新
    KKRefreshStatusDataUnexpect_Footer, //数据异常_上拉刷新
    
    KKRefreshStatusNetworkError, //网络错误
    KKRefreshStatusNetworkError_Header, //网络错误_下拉刷新
    KKRefreshStatusNetworkError_Footer, //网络错误_上拉刷新
    
    KKRefreshStatusNoMoreData_Header,//没有数据_下拉刷新
    KKRefreshStatusMoreData_Header,  //有数据_下拉刷新
    
    KKRefreshStatusNoMoreData_Footer,//没有数据_上拉刷新
    KKRefreshStatusMoreData_Footer   //有数据_上拉刷新
};

@protocol KKViewModelProtocol <NSObject>

@optional

- (instancetype) initWithModel:(id) model;

/**
 初始化
 */
- (void) kk_initialize;


@end
