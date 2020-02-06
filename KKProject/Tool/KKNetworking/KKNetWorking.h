//
//  KKNetWorking.h
//  ot-dayu
//
//  Created by yangcankun on 2019/1/7.
//  Copyright © 2019 YangCK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKAccountHelper.h"
#import "KKErrorHelper.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 *
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 */
typedef void (^KKDownloadProgress)(int64_t bytesRead,
                                   int64_t totalBytesRead);

typedef KKDownloadProgress KKGetProgress;
typedef KKDownloadProgress KKPostProgress;

/*!
 *
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^KKUploadProgress)(int64_t bytesWritten,
                                 int64_t totalBytesWritten);


typedef NS_ENUM(NSUInteger, KKResponseType) {
    kKKResponseTypeJSON = 1, // 默认
    kKKResponseTypeXML  = 2, // XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    kKKResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, KKRequestType) {
    kKKRequestTypeJSON = 1, // 默认
    kKKRequestTypePlainText  = 2 // 普通text/html
};

@class NSURLSessionTask;

typedef void(^KKResponseSuccess)(NSURLResponse * response, id responseObject);
typedef void(^KKResponseError)(NSURLResponse * response, NSError *error);
typedef void(^KKResponseFail)(NSError *error);
typedef NSDictionary *_Nullable(^KKRequestHeader)(void);

@interface KKNetWorking : NSObject

/*!
 *
 *  用于指定网络请求接口的基础url，如：
 *  http://henishuo.com或者http://101.200.209.244
 *  通常在AppDelegate中启动时就设置一次就可以了。如果接口有来源
 *  于多个服务器，可以调用更新
 *
 *  @param baseUrl 网络接口的基础url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;

/**
 *    设置请求超时时间，默认为60秒
 *
 *    @param timeout 超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout;

/**
 *    当检查到网络异常时，是否从从本地提取数据。默认为NO。一旦设置为YES,当设置刷新缓存时，
 *  若网络异常也会从缓存中读取数据。同样，如果设置超时不回调，同样也会在网络异常时回调，除非
 *  本地没有数据！
 *
 *    @param shouldObtain    YES/NO
 */
+ (void)obtainDataFromLocalWhenNetworkUnconnected:(BOOL)shouldObtain;

/**
 *
 *    默认只缓存GET请求的数据，对于POST请求是不缓存的。如果要缓存POST获取的数据，需要手动调用设置
 *  对JSON类型数据有效，对于PLIST、XML不确定！
 *
 *    @param isCacheGet            默认为YES
 *    @param shouldCachePost    默认为NO
 */
+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost;

/**
 *
 *    获取缓存总大小/bytes
 *
 *    @return 缓存大小
 */
+ (unsigned long long)totalCacheSize;

/**
 *
 *    清除缓存
 */
+ (void)clearCaches;

/*!
 *
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开，默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;


/**
 是否仅返回成功时,responseObject中key为data的value值(即responseObject[data])

 @param isResponse 默认是true 反之则返回responseObject
 */
+ (void)enableFormatterResponse:(BOOL)isResponse;

/*!
 *
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *
 *  @param requestType 请求格式，默认为JSON
 *  @param responseType 响应格式，默认为JSO，
 *  @param shouldAutoEncode YES or NO,默认为NO，是否自动encode url
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)configRequestType:(KKRequestType)requestType
             responseType:(KKResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest;

/*!
 *
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *
 *    取消所有请求
 */
+ (void)cancelAllRequest;
/**
 *
 *    取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的KKURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *
 *    @param url                URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
+ (void)cancelRequestWithURL:(NSString *_Nonnull)url;




/**
 默认header的Get请求
 
 @param url 地址
 @param params 参数
 @param success 成功会掉
 @param error 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_GetDefauleHeaderWithUrl:(NSString *_Nonnull)url
                                          params:(NSDictionary *)params
                                         success:(KKResponseSuccess)success
                                           error:(KKResponseError)error
                                            fail:(KKResponseFail)fail;


/**
 Get请求-默认不缓存没有progress
 
 @param url 地址
 @param params 参数
 @param requestHeader 请求头
 @param success 成功回调
 @param error 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_GetWithUrl:(NSString *_Nonnull)url
                             params:(NSDictionary *)params
                      requestHeader:(KKRequestHeader)requestHeader
                            success:(KKResponseSuccess)success
                              error:(KKResponseError)error
                               fail:(KKResponseFail)fail;


/**
 Get请求-完整参数
 
 @param url 地址
 @param refreshCache 是否缓存
 @param params 参数
 @param requestHeader 请求头
 @param progress 进度
 @param success 成功回调
 @param error 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_GetWithUrl:(NSString *_Nonnull)url
                       refreshCache:(BOOL)refreshCache
                             params:(NSDictionary *)params
                      requestHeader:(KKRequestHeader)requestHeader
                           progress:(KKPostProgress)progress
                            success:(KKResponseSuccess)success
                              error:(KKResponseError)error
                               fail:(KKResponseFail)fail;

/**
 默认header的POST请求
 
 @param url 地址
 @param params 参数
 @param success 成功会掉
 @param error 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_PostDefauleHeaderWithUrl:(NSString *_Nonnull)url
                                           params:(NSDictionary *)params
                                          success:(KKResponseSuccess)success
                                            error:(KKResponseError)error
                                             fail:(KKResponseFail)fail;

/**
 POST请求-默认不缓存没有progress
 
 @param url 地址
 @param params 参数
 @param requestHeader 请求头
 @param success 成功回调
 @param error 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_PostWithUrl:(NSString *_Nonnull)url
                              params:(NSDictionary *)params
                       requestHeader:(KKRequestHeader)requestHeader
                             success:(KKResponseSuccess)success
                               error:(KKResponseError)error
                                fail:(KKResponseFail)fail;

/**
 POST请求-完整参数
 
 @param url 地址
 @param refreshCache 是否缓存
 @param params 参数
 @param requestHeader 请求头
 @param progress 进度
 @param success 成功回调
 @param error 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_PostWithUrl:(NSString *_Nonnull)url
                        refreshCache:(BOOL)refreshCache
                              params:(NSDictionary *)params
                       requestHeader:(KKRequestHeader)requestHeader
                            progress:(KKGetProgress)progress
                             success:(KKResponseSuccess)success
                               error:(KKResponseError)error
                                fail:(KKResponseFail)fail;

/******************************************FORM DATA************************************************/

/**
 FormData格式请求-只有参数没有data
 
 @param url 地址
 @param params 参数
 @param success 成功回调
 @param errorCB 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_PostDefaultHeaderFormDataWithUrl:(NSString *_Nonnull)url
                                                   params:(NSDictionary *)params
                                                  success:(KKResponseSuccess)success
                                                    error:(KKResponseError)errorCB
                                                     fail:(KKResponseFail)fail;

/**
 默认FormData格式请求-默认了请求头与图片名、格式
 
 @param url 地址
 @param params 参数
 @param fileData 图片Data
 @param fileName 文件名
 @param progress 进度
 @param success 成功回调
 @param errorCB 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_PostDefaultHeaderFormDataWithUrl:(NSString *_Nonnull)url
                                                   params:(NSDictionary *)params
                                                 fileData:(NSData *)fileData
                                                 fileName:(NSString *)fileName
                                                 progress:(KKDownloadProgress)progress
                                                  success:(KKResponseSuccess)success
                                                    error:(KKResponseError)errorCB
                                                     fail:(KKResponseFail)fail;

/**
 默认文件参数名的formdata请求
 
 @param url 地址
 @param params 参数
 @param requestHeader 请求头
 @param fileData 图片Data
 @param fileName 文件名
 @param progress 进度
 @param success 成功回调
 @param errorCB 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_PostFormDataWithUrl:(NSString *_Nonnull)url
                                      params:(NSDictionary *)params
                               requestHeader:(KKRequestHeader)requestHeader
                                    fileData:(NSData *)fileData
                                    fileName:(NSString *)fileName
                                    progress:(KKDownloadProgress)progress
                                     success:(KKResponseSuccess)success
                                       error:(KKResponseError)errorCB
                                        fail:(KKResponseFail)fail;
/**
 完整formdata请求
 
 @param url 地址
 @param params 参数
 @param requestHeader 请求头
 @param fileData 图片Data
 @param fileName 文件名
 @param name 文件参数名
 @param mimeType 文件类型
 @param progress 进度
 @param success 成功回调
 @param errorCB 错误码处理
 @param fail 失败回调
 @return 请求
 */
+ (NSURLSessionTask *)kk_PostFormDataWithUrl:(NSString *_Nonnull)url
                                      params:(NSDictionary *)params
                               requestHeader:(KKRequestHeader)requestHeader
                                    fileData:(NSData *)fileData
                                    fileName:(NSString *)fileName
                                        name:(NSString *)name
                                    mimeType:(NSString *)mimeType
                                    progress:(KKDownloadProgress)progress
                                     success:(KKResponseSuccess)success
                                       error:(KKResponseError)errorCB
                                        fail:(KKResponseFail)fail;





@end

NS_ASSUME_NONNULL_END
