//
//  KKDownLoadTask.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDownLoadTask.h"

@interface KKDownLoadTask ()<NSURLSessionDownloadDelegate>

@end

@implementation KKDownLoadTask



#pragma mark -NSURLSessionDownloadDelegate




-(void)start{
    
    if (self.downLoadSession == nil) {
        self.downLoadSession = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration delegate:self delegateQueue:NSOperationQueue.alloc.init];
    }
    
    if (self.downloadTask == nil) {
        
        if (self.downLoadResumeData) {//继续下载
            //暂停下载返回的数据
            self.downloadTask = [self.downLoadSession downloadTaskWithResumeData:self.downLoadResumeData];
            [self.downloadTask resume];
            
        }else{//开始下载
            NSURL* url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            self.downloadTask = [self.downLoadSession downloadTaskWithRequest:request];
            [self.downloadTask resume];
        }
    }
}


/// 暂停文件下载
-(void)pause{
    __weak typeof(self) weakSelf = self;
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //resumeData:包含了继续下载的位置或者下载的路径
        strongSelf.downLoadResumeData = resumeData;
        strongSelf.downloadTask = nil;
    }];
}


#pragma mark -NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    // 文件将要移动到的指定目录
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    // 新文件路径
    NSString *newFilePath = [documentsPath stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
    
    NSLog(@"File downloaded to: %@",newFilePath);
    
    // 移动文件到新路径
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:newFilePath error:nil];
}


/**
 *  每次写入数据到临时文件时，就会调用一次这个方法。可在这里获得下载进度
 *
 *  @param bytesWritten              这次写入的文件大小
 *  @param totalBytesWritten         已经写入沙盒的文件大小
 *  @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // 下载进度
    
    NSLog(@"  %0.2lf", 1.0f * totalBytesWritten / totalBytesExpectedToWrite);
    
}


@end
