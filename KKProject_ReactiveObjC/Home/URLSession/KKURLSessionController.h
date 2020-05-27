//
//  KKURLSessionController.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKURLSessionController : KKViewController<NSURLSessionDelegate>

@end

/**********************************************
        NSURLSeesion的核心类
 
 1.NSURLSessionConfiguration:指定NSURLSession的配置信息,决定NSURLSession的种类,
 例如:Http的额外headers,请求的timeOut,cookie等等.
    默认配置(defaultSessionConfiguration):使用硬盘持久化cache,证书,使用共享cookie存储
    快速配置(ephemeralSessionConfiguration):任何和session相关配置存储到内存中.
    后台配置(backgroudSessionConfigurationWithIdentifier):后台传输配置
 
 
 2.NSURLSessionTask(会话任务)及其三个子类:NSURLSessionDataTask(获取数据),NSURLSessionUploadTask(上传),
 NSURLSessionDownloadTask(下载),NSURLSessionWebSocketTask
 
                --------NSURLSessionWebSocketTask
                -
    NSURLSessionTask------NSURLSessionDownloadTask
                -
                -
                -----NSURLSessionDataTask---NSURLSessionUploadTask
 
 
 
 3.NSURLSesssion:会话基于NSURLSession网络开发的核心组件,由上文configuration来
 配置,然后作为工厂,创建NSURLSessionTask进行数据传输
 
 

 4.NSURLRequest:指定请求的URL和cache策略
 
 
 5.NSURLCache:请求返回的response
 
 
 6.NSURLResponse(及其子类NSHTTPURLResponse)

 
 
 7.代理delegate
 
 
 
 NSURLSession:处理session层次事件,针对整体网络会话(如证书、重定向等)
 NSURLSessionTaskDelegate:处理所有类型Task层次公共事件,针对网络任务(开始、结束、单次proposedResponse等)
 NSURLSessionDownloadDelegate:处理download类型Task层次事件,针对下载任务的特殊代理
 NSURLSessionDataDelegate:处理download类型Task层次事件
 NSURLSessionStreamDelegate:为数据流上传提供数据源的特殊代理
 

***********************************************/

NS_ASSUME_NONNULL_END
