//
//  KKURLSessionView_Download.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/18.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKURLSessionView_Download.h"

@interface KKURLSessionView_Download ()<NSURLSessionDelegate,NSURLSessionDownloadDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;

@end

@implementation KKURLSessionView_Download

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self bindViewModel];
    }
    return self;
}

- (void)setupView{
    
    self.button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"文件上传请求/开始" forState:UIControlStateNormal];
        [button setTitle:@"文件上传请求/暂停" forState:UIControlStateSelected];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.superview).offset(50).priorityMedium();
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        button;
    });
    
    self.cancelButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"文件上传请求/取消" forState:UIControlStateNormal];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.button.mas_bottom).offset(50);
            make.centerX.equalTo(button.superview);
            make.width.equalTo(button.superview).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        button;
    });
    
    self.textView = ({
        UITextView *view = UITextView.new;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cancelButton.mas_bottom).offset(40);
            make.centerX.equalTo(view.superview);
            make.width.equalTo(view.superview).multipliedBy(0.85);
            make.bottom.equalTo(view.superview.mas_bottom).offset(-40);
        }];
        view;
    });
    
    
    @weakify(self);
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        x.selected = !x.selected;
        if (x.selected) {
            [self resume];
        }else{
            [self suspend];
        }
    }];
    
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self cancel];
    }];
    
}

-(void)bindViewModel{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSString * url = [NSString stringWithFormat:@"https://upfile.asqql.com/2009pasdfasdfic2009s305985-ts/2018-4/2018423202071807.gif"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
    
    self.session = session;
    self.downloadTask = downloadTask;
}

-(void)resume{
    
    if (self.resumeData) {
        self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
        [self.downloadTask resume];
    }else{
        [self.downloadTask resume];
    }
    
}


-(void)suspend{
    if (self.downloadTask.state == NSURLSessionTaskStateRunning) {
        [self.downloadTask suspend];
    }
}



-(void)cancel{
    @weakify(self);
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        @strongify(self);
        self.resumeData = resumeData;
    }];
}



#pragma mark -NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"NSURLSessionDelegate:::询问>>服务器客户端配合验证--会话级别");
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>下载任务已经恢复下载");
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSLog(@"NSURLSessionTaskDelegate:::通知>>下载任务进度");
    if (totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            self.textView.text = [NSString stringWithFormat:@"%0.2lf",1.0f * totalBytesWritten / totalBytesExpectedToWrite];
        }];
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>任务信息收集完成");
    NSLog(@"::::::::::::相关讯息::::::::::::\n总时间:%@\n,重定向次数:%zd\n,派生的子请求:%zd",metrics.taskInterval,metrics.redirectCount,metrics.transactionMetrics.count);
}

//location 临时文件的位置url 需要手动移动文件至需要保存的目录
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"NSURLSessionDownloadDelegate:::通知>>下载任务已经完成");
    self.resumeData = nil;
}


//无论成功、失败或者取消
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>任务完成");
    
    if (!error) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            self.textView.text = @"下载完成";
            
        }];
        
    }else {
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            self.textView.text = error.localizedDescription;
        }];
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
