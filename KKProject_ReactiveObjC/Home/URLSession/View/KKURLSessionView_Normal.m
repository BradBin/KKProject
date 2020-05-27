//
//  KKURLSessionView_Normal.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/18.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKURLSessionView_Normal.h"

@interface KKURLSessionView_Normal ()<NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UITextView *textView;


@property (nonatomic, strong) NSURLSession         *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;


@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, assign) NSUInteger expectlength;


@end

@implementation KKURLSessionView_Normal

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self bindViewModel];
    }
    return self;
}

-(void)setupView{
    
    self.button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button setTitle:@"普通网络请求/开始" forState:UIControlStateNormal];
        [button setTitle:@"普通网络请求/暂停" forState:UIControlStateSelected];
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
        [button setTitle:@"普通网络请求/取消" forState:UIControlStateNormal];
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
        [self resume];
    }];
    
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.textView.text  = nil;
        [self cancelTask];
    }];
    
}


-(void)bindViewModel{
    
    
    
}

-(void)resume{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://api.androidhive.info/volley/person_object.json"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    ///默认task的状态是挂起状态
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
    [dataTask resume];
    self.session = session;
    self.dataTask = dataTask;
}


-(void)cancelTask{
    
    switch (self.dataTask.state) {
        case NSURLSessionTaskStateSuspended:
        case NSURLSessionTaskStateRunning:{
            [self.dataTask cancel];
        } break;
            
        default:
            break;
    }
}


#pragma mark -NSURLSessionTaskDelegate

#pragma mark -准备开始请求、询问是否重定向
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler{
    NSLog(@"NSURLSessionTaskDelegate:询问是否重定向");
    completionHandler(request);
}

#pragma mark -任务信息收集完成
/***********************************************
 对发送请求/DNS查询/TLS握手/请求响应等各种环节时间上的
 统计. 更易于我们检测, 分析我们App的请求缓慢到底是发生
 在哪个环节, 并对此进行优化提升我们APP的性能.
 ***********************************************/
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics{
    NSLog(@"NSURLSessionTaskDelegate:::通知>>任务信息收集完成");
    NSLog(@"::::::::::::相关讯息::::::::::::\n总时间:%@\n,重定向次数:%zd\n,派生的子请求:%zd",metrics.taskInterval,metrics.redirectCount,metrics.transactionMetrics.count);
}


#pragma mark -通知任务完成,无论成功、失败或者取消
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"NSURLSessionTaskDelegate:通知>任务完成");
    if (error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.textView.text = error.localizedDescription;
        }];
    }else{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSString *string = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
            self.textView.text = string;
        }];
    }
}


#pragma mark -NSURLSessionDelegate

#pragma mark -服务器需要配合客户端验证----响应来自远程服务器的会话级别认证请求
-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSLog(@"NSURLSessionDelegate: 服务器客户端配合验证----会话级别");
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
}

#pragma mark -NSURLSessionDataDelegate

#pragma mark -服务器返回头响应,询问下一步操作(取消操作、普通传输、下载、数据流传输)
-(void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    NSLog(@"NSURLSessionDataDelegate: 服务器返回头响应,询问下一步操作(取消操作、普通传输、下载、数据流传输)");
    self.expectlength = [response expectedContentLength];
    completionHandler(NSURLSessionResponseAllow);
}

#pragma mark -服务器成功返回数据
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"NSURLSessionDataDelegate:通知>>服务器成功返回数据 %0.2lf",1.0f * [self.data length]/((float) self.expectlength));
    [self.data appendData:data];
}

#pragma mark -是否把Response存储到cache中
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler{
    NSLog(@"NSURLSessionDataDelegate:询问>>是否把Response存储到Cache中");
    NSCachedURLResponse *resp = [[NSCachedURLResponse alloc] initWithResponse:proposedResponse.response data:proposedResponse.data userInfo:nil storagePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(resp);
}




#pragma mark -Lazy Instance
-(NSMutableData *)data{
    if (_data == nil) {
        _data = NSMutableData.data;
    }
    return _data;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
