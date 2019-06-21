//
//  KKWebViewController.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/20.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKWebViewController.h"
#import "WKWebView+KKProgress.h"
#import <dsBridge/dsbridge.h>

@interface KKWebViewController ()<WKUIDelegate,WKNavigationDelegate,KKWebApiProtocol>
@property (nonatomic,strong) DWKWebView *webView;
@property (nonatomic,strong) NSArray    *webApis;
@property (nonatomic,  copy) NSString   *webURLString;
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation KKWebViewController

-(instancetype)initWithURLString:(NSString *)URLString webApis:(NSArray<KKWebApi *> *)webApis{
    self = [super init];
    if (self) {
        _webApis      = [webApis copy];
        _webURLString = [URLString copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navigationBar.hidden = true;
}


-(void)kk_addSubviews{
    [super kk_addSubviews];
    
    self.webView = ({
        WKWebViewConfiguration *config = WKWebViewConfiguration.alloc.init;
        config.preferences.minimumFontSize   = 8;//最小的文字大小
        config.preferences.javaScriptEnabled = true;//是否可以进行js交互,default is true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true;//交互打开窗口default is false
    
        config.userContentController = WKUserContentController.alloc.init;//内容交互控制器 js和webView交互
        
        config.suppressesIncrementalRendering = true; // 是否支持记忆读取
        config.allowsInlineMediaPlayback      = true;//是否允许html视频播放画中画中
        config.allowsAirPlayForMediaPlayback  = true;//AirPlay允许播放
        config.allowsPictureInPictureMediaPlayback = true;
    
        [config setValue:@true forKey:@"allowUniversalAccessFromFileURLs"]; //支持跨域
        
        if (@available(iOS 10.0, *)) {//数据检测类型
            config.dataDetectorTypes = UIDataDetectorTypeAll;
        }
        
        config.selectionGranularity = WKSelectionGranularityDynamic;//用户长按复制
        
        DWKWebView *view        = [[DWKWebView alloc] initWithFrame:CGRectZero configuration:config];
        view.DSUIDelegate       = self;
        view.navigationDelegate = self;
        
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view.superview);
            
        }];
        view;
    });
    
    if (self.webApis) {
        for (KKWebApi *weabApi in self.webApis) {
            weabApi.delegate = self;
            [self.webView addJavascriptObject:weabApi namespace:nil];
        }
    }
    @weakify(self);
    [self deleteWebCacheWithBlock:^{
        @strongify(self);
        NSLog(@"---  %@ ",[NSURL URLWithString:self.webURLString]);
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURLString]]];
    }];
    
}

- (void)deleteWebCacheWithBlock:(void(^)(void))block {
    if (@available(iOS 9.0 , *)) {
        //                NSSet *websiteDataTypes = [NSSet setWithArray:@[
        //                                                                WKWebsiteDataTypeDiskCache,
        //                                                                //WKWebsiteDataTypeOfflineWebApplicationCache,
        //                                                                WKWebsiteDataTypeMemoryCache,
        //                                                                WKWebsiteDataTypeLocalStorage,
        //                                                                //WKWebsiteDataTypeCookies,
        //                                                                //WKWebsiteDataTypeSessionStorage,
        //                                                                //WKWebsiteDataTypeIndexedDBDatabases,
        //                                                                //WKWebsiteDataTypeWebSQLDatabases
        //                                                                ]];
        //// All kinds of data
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
            if (block) {
                block();
            }
        }];
    }else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        if (block) {
            block();
        }
    }
}

#pragma mark -
#pragma mark - KKWebApiProtocol
-(void)kk_errorHaveFonudWithWebApi:(KKWebApi *)webApi error:(NSError *)error{
    NSLog(@"kk_errorHaveFonudWithWebApi");
}

#pragma mark -
#pragma mark - WKNavigationDelegate
/**
 页面开始加载时调用
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时调用");
}
/**
 当内容开始返回时调用
 */
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容开始返回时调用");
}
/**
 页面加载完成之后调用
 */
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成之后调用");
}
/**
 页面加载失败时调用
 */
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailProvisionalNavigation页面加载失败时调用: %@",error.localizedDescription);
    
#if 0
    if (self.navigationController.topViewController == self) {
        if ([webView canGoBack]) {
            [webView canGoBack];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }else{
        if ([webView canGoBack]) {
            [webView canGoBack];
        }else{
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }
#else
    if (self.presentingViewController) {
        if ([webView canGoBack]) {
            [webView canGoBack];
        }else{
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }else{
        if ([webView canGoBack]) {
            [webView canGoBack];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }
#endif
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailNavigation:%@",error.localizedDescription);
}
#pragma mark - 页面跳转的代理方法
/**
 接收到服务器跳转请求之后调用
 */
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"接收到服务器跳转请求之后调用");
}
/**
 在收到响应后，决定是否跳转
 */
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"在收到响应后，决定是否跳转");
    decisionHandler(WKNavigationResponsePolicyAllow);
}
/**
 在发送请求之前，决定是否跳转
 */
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"在发送请求之前，决定是否跳转");
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark -
#pragma mark - WKUIDelegate
/**
 webView界面中有弹出警告框时调用
 
 @param webView webview
 @param message 警告框中的内容
 @param frame 主窗口
 @param completionHandler 警告框消失调用
 */
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"webView界面中有弹出警告框时调用");
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
