//
//  KKNetWorking.m
//  ot-dayu
//
//  Created by yangcankun on 2019/1/7.
//  Copyright © 2019 YangCK. All rights reserved.
//

#import "KKNetWorking.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFURLSessionManager.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

static NSString *kk_privateNetworkBaseUrl = nil;
static BOOL kk_isEnableInterfaceDebug     = YES;
static BOOL kk_isEnableResponse           = YES;
static BOOL kk_shouldAutoEncode           = NO;
static NSDictionary *kk_httpHeaders       = nil;
static KKResponseType kk_responseType = kKKResponseTypeJSON;
static KKRequestType  kk_requestType  = kKKRequestTypeJSON;
static NSMutableArray *kk_requestTasks;
static BOOL kk_cacheGet = NO;
static BOOL kk_cachePost = NO;
static BOOL kk_shouldCallbackOnCancelRequest = YES;
static NSTimeInterval kk_timeout = 20.0f;
static BOOL kk_shoulObtainLocalWhenUnconnected = NO;

@implementation KKNetWorking

+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost {
    kk_cacheGet = isCacheGet;
    kk_cachePost = shouldCachePost;
}

+ (void)updateBaseUrl:(NSString *)baseUrl {
    kk_privateNetworkBaseUrl = baseUrl;
}

+ (NSString *)baseUrl {
    return kk_privateNetworkBaseUrl;
}

+ (void)setTimeout:(NSTimeInterval)timeout {
    kk_timeout = timeout;
}

+ (void)obtainDataFromLocalWhenNetworkUnconnected:(BOOL)shouldObtain {
    kk_shoulObtainLocalWhenUnconnected = shouldObtain;
}

+ (void)enableInterfaceDebug:(BOOL)isDebug {
    kk_isEnableInterfaceDebug = isDebug;
}

+ (BOOL)isDebug {
    return kk_isEnableInterfaceDebug;
}


+ (void)enableFormatterResponse:(BOOL)isResponse{
    kk_isEnableResponse = isResponse;
}

+ (BOOL)isResponse{
    return kk_isEnableResponse;
}

static inline NSString *cachePath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/KKNetworkingCaches"];
}

+ (void)clearCaches {
    NSString *directoryPath = cachePath();
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
        
        if (error) {
            NSLog(@"KKNetworking clear caches error: %@", error);
        } else {
            NSLog(@"KKNetworking clear caches ok");
        }
    }
}

+ (unsigned long long)totalCacheSize {
    NSString *directoryPath = cachePath();
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}

+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (kk_requestTasks == nil) {
            kk_requestTasks = [[NSMutableArray alloc] init];
        }
    });
    
    return kk_requestTasks;
}

+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (url == nil) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

+ (void)configRequestType:(KKRequestType)requestType
             responseType:(KKResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest {
    kk_requestType = requestType;
    kk_responseType = responseType;
    kk_shouldAutoEncode = shouldAutoEncode;
    kk_shouldCallbackOnCancelRequest = shouldCallbackOnCancelRequest;
}

+ (BOOL)shouldEncode {
    return kk_shouldAutoEncode;
}

+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders {
    kk_httpHeaders = httpHeaders;
}

+ (NSDictionary *(^)(void))defaultToken {
    return ^(void){
        if (!KKAccountHelper.shared.isLogin) {
            return @{};
        }
        return @{
                 @"user_token":KKAccountHelper.shared.token
                 };
        
    };
}


+ (NSURLSessionTask *)kk_GetDefauleHeaderWithUrl:(NSString *)url
                                          params:(NSDictionary *)params
                                         success:(KKResponseSuccess)success
                                           error:(KKResponseError)error
                                            fail:(KKResponseFail)fail {
    return [self kk_GetWithUrl:url
                        params:params
                 requestHeader:[self defaultToken]
                       success:success
                         error:error
                          fail:fail];
}

+ (NSURLSessionTask *)kk_GetWithUrl:(NSString *)url
                             params:(NSDictionary *)params
                      requestHeader:(KKRequestHeader)requestHeader
                            success:(KKResponseSuccess)success
                              error:(KKResponseError)error
                               fail:(KKResponseFail)fail {
    
    return [self kk_GetWithUrl:url
                  refreshCache:YES
                        params:params
                 requestHeader:requestHeader
                      progress:nil
                       success:success
                         error:error
                          fail:fail];
}

+ (NSURLSessionTask *)kk_GetWithUrl:(NSString *)url
                       refreshCache:(BOOL)refreshCache
                             params:(NSDictionary *)params
                      requestHeader:(KKRequestHeader)requestHeader
                           progress:(KKPostProgress)progress
                            success:(KKResponseSuccess)success
                              error:(KKResponseError)error
                               fail:(KKResponseFail)fail {
    
    return [self _requestWithUrl:url
                    refreshCache:refreshCache
                       httpMedth:1
                          params:params
                   requestHeader:requestHeader
                        progress:progress
                         success:success
                           error:error
                            fail:fail];
    
}

+ (NSURLSessionTask *)kk_PostDefauleHeaderWithUrl:(NSString *)url
                                           params:(NSDictionary *)params
                                          success:(KKResponseSuccess)success
                                            error:(KKResponseError)error
                                             fail:(KKResponseFail)fail {
    return [self kk_PostWithUrl:url
                         params:params
                  requestHeader:[self defaultToken]
                        success:success
                          error:error
                           fail:fail];
}



+ (NSURLSessionTask *)kk_PostWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                       requestHeader:(KKRequestHeader)requestHeader
                             success:(KKResponseSuccess)success
                               error:(KKResponseError)error
                                fail:(KKResponseFail)fail {
    
    return [self kk_PostWithUrl:url
                   refreshCache:YES
                         params:params
                  requestHeader:requestHeader
                       progress:nil
                        success:success
                          error:error
                           fail:fail];
}




+ (NSURLSessionTask *)kk_PostWithUrl:(NSString *)url
                        refreshCache:(BOOL)refreshCache
                              params:(NSDictionary *)params
                       requestHeader:(KKRequestHeader)requestHeader
                            progress:(KKGetProgress)progress
                             success:(KKResponseSuccess)success
                               error:(KKResponseError)error
                                fail:(KKResponseFail)fail {
    return [self _requestWithUrl:url
                    refreshCache:refreshCache
                       httpMedth:2
                          params:params
                   requestHeader:requestHeader
                        progress:progress
                         success:success
                           error:error
                            fail:fail];
}


+ (NSURLSessionTask *)_requestWithUrl:(NSString *)url
                         refreshCache:(BOOL)refreshCache
                            httpMedth:(NSUInteger)httpMethod
                               params:(NSDictionary *)params
                        requestHeader:(KKRequestHeader)requestHeader
                             progress:(KKDownloadProgress)progress
                              success:(KKResponseSuccess)success
                                error:(KKResponseError)errorCB
                                 fail:(KKResponseFail)fail {
    
    AFHTTPSessionManager *manager = [self managerWithHeader:requestHeader];
    NSString *absolute = [self absoluteUrlWithPath:url];
    
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        NSURL *absouluteURL = [NSURL URLWithString:absolute];
        
        if (absouluteURL == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    if ([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    
    NSURLSessionTask *session = nil;
    
    if (httpMethod == 1) {
        if (kk_cacheGet && !refreshCache) {// 获取缓存
            id response = [KKNetWorking cahceResponseWithURL:absolute
                                                  parameters:params];
            if (response) {
                if (success) {
                    [self successResponseObj:response response:nil callback:success error:errorCB];
                    
                    if ([self isDebug]) {
                        [self logWithSuccessResponse:response
                                                 url:absolute
                                              params:params];
                    }
                }
                
                return nil;
            }
        }
        
        session = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponseObj:responseObject response:task.response callback:success error:errorCB];
            
            if (kk_cacheGet) {
                [self cacheResponseObject:responseObject request:task.currentRequest parameters:params];
            }
            
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self allTasks] removeObject:task];
            
            if ([error code] < 0 && kk_cacheGet) {// 获取缓存
                id response = [KKNetWorking cahceResponseWithURL:absolute
                                                      parameters:params];
                if (response) {
                    if (success) {
                        [self successResponseObj:response response:task.response callback:success error:errorCB];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                } else {
                    [self handleCallbackWithError:error fail:fail];
                    
                    if ([self isDebug]) {
                        [self logWithFailError:error url:absolute params:params];
                    }
                    
                }
            } else {
                [self handleCallbackWithError:error fail:fail];
                
                if ([self isDebug]) {
                    [self logWithFailError:error url:absolute params:params];
                }
            }
        }];
    }else if (httpMethod == 2) {
        if (kk_cachePost && !refreshCache) {// 获取缓存
            id response = [KKNetWorking cahceResponseWithURL:absolute
                                                  parameters:params];
            
            if (response) {
                if (success) {
                    [self successResponseObj:response response:nil callback:success error:errorCB];
                    
                    if ([self isDebug]) {
                        [self logWithSuccessResponse:response
                                                 url:absolute
                                              params:params];
                    }
                }
                
                return nil;
            }
        }
        
        session = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponseObj:responseObject response:task.response callback:success error:errorCB];
            //            [self successResponse:responseObject callback:success];
            
            if (kk_cachePost) {
                [self cacheResponseObject:responseObject request:task.currentRequest  parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self allTasks] removeObject:task];
            
            if ([error code] < 0 && kk_cachePost) {// 获取缓存
                id response = [KKNetWorking cahceResponseWithURL:absolute
                                                      parameters:params];
                
                if (response) {
                    if (success) {
                        
                        [self successResponseObj:response response:nil callback:success error:errorCB];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                } else {
                    [self handleCallbackWithError:error fail:fail];
                    
                    if ([self isDebug]) {
                        [self logWithFailError:error url:absolute params:params];
                    }
                }
            } else {
                
                [self handleCallbackWithError:error fail:fail];
                
                if ([self isDebug]) {
                    [self logWithFailError:error url:absolute params:params];
                }
            }
        }];
    }
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (NSURLSessionTask *)kk_PostDefaultHeaderFormDataWithUrl:(NSString *)url
                                                   params:(NSDictionary *)params
                                                  success:(KKResponseSuccess)success
                                                    error:(KKResponseError)errorCB
                                                     fail:(KKResponseFail)fail {
    
    return [self kk_PostDefaultHeaderFormDataWithUrl:url
                                              params:params
                                            fileData:nil
                                            fileName:nil
                                            progress:nil
                                             success:success
                                               error:errorCB
                                                fail:fail];
    
}

+ (NSURLSessionTask *)kk_PostDefaultHeaderFormDataWithUrl:(NSString *)url
                                                   params:(NSDictionary *)params
                                                 fileData:(NSData *)fileData
                                                 fileName:(NSString *)fileName
                                                 progress:(KKDownloadProgress)progress
                                                  success:(KKResponseSuccess)success
                                                    error:(KKResponseError)errorCB
                                                     fail:(KKResponseFail)fail {
    return [self kk_PostFormDataWithUrl:url
                                 params:params
                          requestHeader:[self defaultToken]
                               fileData:fileData
                               fileName:fileName
                               progress:progress
                                success:success
                                  error:errorCB
                                   fail:fail];
    
}

+ (NSURLSessionTask *)kk_PostFormDataWithUrl:(NSString *)url
                                      params:(NSDictionary *)params
                               requestHeader:(KKRequestHeader)requestHeader
                                    fileData:(NSData *)fileData
                                    fileName:(NSString *)fileName
                                    progress:(KKDownloadProgress)progress
                                     success:(KKResponseSuccess)success
                                       error:(KKResponseError)errorCB
                                        fail:(KKResponseFail)fail {
    return [self kk_PostFormDataWithUrl:url
                                 params:params
                          requestHeader:requestHeader
                               fileData:fileData
                               fileName:fileName
                                   name:@"file"
                               mimeType:@"image/jpeg"
                               progress:progress
                                success:success
                                  error:errorCB
                                   fail:fail];
    
}


+ (NSURLSessionTask *)kk_PostFormDataWithUrl:(NSString *)url
                                      params:(NSDictionary *)params
                               requestHeader:(KKRequestHeader)requestHeader
                                    fileData:(NSData *)fileData
                                    fileName:(NSString *)fileName
                                        name:(NSString *)name
                                    mimeType:(NSString *)mimeType
                                    progress:(KKDownloadProgress)progress
                                     success:(KKResponseSuccess)success
                                       error:(KKResponseError)errorCB
                                        fail:(KKResponseFail)fail {
    
    
    NSString *absolute = [self absoluteUrlWithPath:url];
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        NSURL *absouluteURL = [NSURL URLWithString:absolute];
        
        if (absouluteURL == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    if ([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    AFHTTPSessionManager *manager = [self managerWithHeader:requestHeader];
    
    NSURLSessionTask *session = nil;
    session = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (!fileName.isNotBlank && fileData.length > 0) {
            [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponseObj:responseObject response:task.response callback:success error:errorCB];
        [[self allTasks] removeObject:task];
        
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject
                                     url:absolute
                                  params:params];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleCallbackWithError:error fail:fail];
        
        if ([self isDebug]) {
            [self logWithFailError:error url:absolute params:params];
        }
        [[self allTasks] removeObject:task];
    }];
    
    [session resume];
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}



+ (void)handleCallbackWithError:(NSError *)error fail:(KKResponseFail)fail {
    
    if ([error code] == NSURLErrorCancelled) {
        if (kk_shouldCallbackOnCancelRequest) {
            if (fail) {
                fail(error);
            }
        }
    } else {
        if (fail) {
            fail(error);
        }
    }
}

+ (void)successResponseObj:(id)responseData response:(NSURLResponse *)response callback:(KKResponseSuccess)success error:(KKResponseError)error {
    id responseObj = [self tryToParseData:responseData];
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        
        KKError *kkerror = [KKErrorHelper kk_errorWithInfo:responseObj];
        if (kkerror) {
            if ([kkerror kk_isReloginError]) {
                [KKErrorHelper kk_showLoginVCWithBlock:^(UIViewController * _Nonnull vc) {
                    [vc.view showTitle:kkerror.desc];
                }];
                error(response,kkerror);
            }else {
                error(response,kkerror);
            }
            return;
        }
        if (success) {
            if (responseObj[@"data"] && [responseObj[@"data"] class] != [NSNull class] && [self isResponse]) {
                success(response,responseObj[@"data"]);
            } else {
                success(response,responseObj);
            }
            return;
        }
    }
    if (success) {
        success(response,responseObj);
    }
}

+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

+ (AFHTTPSessionManager *)shareManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([self baseUrl] != nil) {
            manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
        } else {
            manager = [AFHTTPSessionManager manager];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
              manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
        }
    });
    return manager;
}

#pragma mark - Private
+ (AFHTTPSessionManager *)managerWithHeader:(KKRequestHeader)header {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [self shareManager];
    
    switch (kk_requestType) {
        case kKKRequestTypeJSON: {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
        case kKKRequestTypePlainText: {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    switch (kk_responseType) {
        case kKKResponseTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case kKKResponseTypeXML: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case kKKResponseTypeData: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    if (header) {
        NSDictionary *httpHeaders = header();
        if (httpHeaders) {
            for (NSString *key in httpHeaders.allKeys) {
                if (httpHeaders[key] != nil) {
                    [manager.requestSerializer setValue:httpHeaders[key] forHTTPHeaderField:key];
                }
            }
        }
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    manager.requestSerializer.timeoutInterval = kk_timeout;
    
    // 设置允许同时最大并发数量，过大容易出问题
    //    manager.operationQueue.maxConcurrentOperationCount = 3;
    //
    //    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    //
    //    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    //    NSSet *certSet = [NSSet setWithObject:certData];
    //
    //    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    //    policy.allowInvalidCertificates = YES;// 是否允许自建证书或无效证书（重要！！！）
    //    policy.validatesDomainName = NO;//是否校验证书上域名与请求域名一致
    //    manager.securityPolicy = policy;
    
    return manager;
}


+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    NSLog(@"\n");
    NSLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",
         [self generateGETAbsoluteURL:url params:params],
         params,
         [[self tryToParseData:response] modelToJSONString]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params {
    NSString *format = @" params: ";
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        format = @"";
        params = @"";
    }
    
    NSLog(@"\n");
    if ([error code] == NSURLErrorCancelled) {
        NSLog(@"\nRequest was canceled mannully, URL: %@ %@%@\n\n",
             [self generateGETAbsoluteURL:url params:params],
             format,
             params);
    } else {
        NSLog(@"\nRequest error, URL: %@ %@%@\n errorInfos:%@\n\n errorCode:%@\n\n",
             [self generateGETAbsoluteURL:url params:params],
             format,
             params,
             [error localizedDescription],
             @([error code]));
    }
}

// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}


+ (NSString *)encodeUrl:(NSString *)url {
    return [self hyb_URLEncode:url];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (NSString *)hyb_URLEncode:(NSString *)url {
    
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    
    return url;
}
#pragma clang diagnostic pop

+ (id)cahceResponseWithURL:(NSString *)url parameters:params {
    id cacheData = nil;
    
    if (url) {
        // Try to get datas from disk
        NSString *directoryPath = cachePath();
        NSString *absoluteURL = [self generateGETAbsoluteURL:url params:params];
        NSString *key = absoluteURL.md5String;
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        if (data) {
            cacheData = data;
            NSLog(@"Read data from cache for url: %@\n", url);
        }
    }
    
    return cacheData;
}

+ (void)cacheResponseObject:(id)responseObject request:(NSURLRequest *)request parameters:params {
    if (request && responseObject && ![responseObject isKindOfClass:[NSNull class]]) {
        NSString *directoryPath = cachePath();
        
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            if (error) {
                NSLog(@"create cache dir error: %@\n", error);
                return;
            }
        }
        
        NSString *absoluteURL = [self generateGETAbsoluteURL:request.URL.absoluteString params:params];
        NSString *key = absoluteURL.md5String;
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSData *data = nil;
        if ([dict isKindOfClass:[NSData class]]) {
            data = responseObject;
        } else {
            data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        }
        
        if (data && error == nil) {
            BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
            if (isOk) {
                NSLog(@"cache file ok for request: %@\n", absoluteURL);
            } else {
                NSLog(@"cache file error for request: %@\n", absoluteURL);
            }
        }
    }
}

+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    
    if ([self baseUrl] == nil || [[self baseUrl] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        absoluteUrl = [NSString stringWithFormat:@"%@%@",
                       [self baseUrl], path];
    }
    
    return absoluteUrl;
}

@end
