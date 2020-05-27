//
//  KKURLSessionView_Upload.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/18.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKURLSessionView_Upload.h"


@interface KKURLSessionView_Upload ()<NSURLSessionTaskDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSURLSessionUploadTask *uploadTask;

@end

@implementation KKURLSessionView_Upload


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
     NSURLSessionConfiguration *config = NSURLSessionConfiguration.defaultSessionConfiguration;
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:@"http://www.chuantu.biz/upload.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        
        NSString *filePath = [NSBundle.mainBundle pathForResource:@"tu" ofType:@"gif"];
        NSData *fileData = [[NSData alloc] initWithContentsOfFile:filePath];
        
//        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromFile:[NSURL URLWithString:filePath]];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:fileData];
        
        self.uploadTask = uploadTask;
}






-(void)resume{
    [self.uploadTask resume];
}

-(void)suspend{
    [self.uploadTask suspend];
}


-(void)cancel{
    [self.uploadTask cancel];
}



#pragma mark - NSURLSessionTaskDelegate
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    NSLog(@"NSURLSessionTaskDelegate : 文件上传进度 %0.2lf",1.0f * totalBytesSent/totalBytesExpectedToSend);
}

#pragma mark 询问>>下一步操作
//服务器返回响应头、询问下一步操作(取消操作、普通传输、下载、数据流传输)
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"NSURLSessionDataDelegate:::通知>>服务器返回响应头。询问>>下一步操作");
    completionHandler(NSURLSessionResponseAllow);
}
#pragma mark 通知>>服务器成功返回数据
//已经收到了一些(大数据可能多次调用)数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSLog(@"NSURLSessionDataDelegate:::通知>>服务器成功返回数据");
}
#pragma mark 询问>>是否把Response存储到Cache中
//任务是否应将响应存储在缓存中
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    NSLog(@"NSURLSessionDataDelegate:::询问>>是否把Response存储到Cache中");
    NSCachedURLResponse * res = [[NSCachedURLResponse alloc]initWithResponse:proposedResponse.response data:proposedResponse.data userInfo:nil storagePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(res);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>任务信息收集完成");
    NSLog(@"::::::::::::相关讯息::::::::::::\n总时间:%@\n,重定向次数:%zd\n,派生的子请求:%zd",metrics.taskInterval,metrics.redirectCount,metrics.transactionMetrics.count);
}


#pragma mark 通知>>任务完成
//无论成功、失败或者取消
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>任务完成");
    if (!error) {
        
         
        
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
