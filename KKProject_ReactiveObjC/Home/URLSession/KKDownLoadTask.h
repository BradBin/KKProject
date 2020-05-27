//
//  KKDownLoadTask.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKDownLoadTask : NSObject

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSURLSession *downLoadSession;
@property (nonatomic, strong) NSData       *downLoadResumeData;



/// 开始下载任务
-(void)start;

/// 暂停下载任务
-(void)pause;


@end

NS_ASSUME_NONNULL_END
