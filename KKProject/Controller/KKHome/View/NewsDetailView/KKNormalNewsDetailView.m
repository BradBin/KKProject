//
//  KKNormalNewsDetailView.m
//  KKProject
//
//  Created by 尤彬 on 2019/7/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKNormalNewsDetailView.h"
#import <dsBridge/dsbridge.h>
#import "KKNewsCommentTableCell.h"

static NSString *const KKWebViewTableCellIdentifier = @"KK.WebView.Table.Cell.Identifier";

@interface KKNormalNewsDetailView()<WKUIDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate,
UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

/**
 展示视图
 first  section: DWKWebView
 secord section: cell
 third  section: cell
 */
@property (nonatomic,strong) UITableView  *tableView;

/**
 wkwebView的父视图,否则wkwebView的内容显示不全
 */
@property (nonatomic,strong) UIScrollView *scrollView;

/**
 新闻内容的正文
 */
@property (nonatomic,strong) DWKWebView   *webView;

/**
 记录新闻内容的正文的高度
 */
@property (nonatomic,assign) CGFloat      webViewHeight;

/**
 webView的URLString
 */
@property (nonatomic,  copy) NSString    *webURLString;

/**
 展示头部作者的详细信息的视图
 */
@property (nonatomic,strong) KKDragableHeaderDetailView *headerDetailView;

/**
 展示底部操作工具条的视图
 */
@property (nonatomic,strong) KKDragableBottomBarView *bottomBarView;

@end

@implementation KKNormalNewsDetailView

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    self = [super init];
    return self;
}

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView removeFromSuperview];
    self.webView = nil;
}

-(void)setupView{
    [super setupView];
    
    self.headerDetailView = ({
        KKDragableHeaderDetailView *view = KKDragableHeaderDetailView.alloc.init;
        @weakify(view);
        view.ajustHeight = ^(CGFloat height) {
            @strongify(view);
            view.frame = CGRectMake(0, 0, KKScreenWidth(), height);
        };
        view;
    });
    
    self.tableView = ({
        UITableView *view    = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        view.delegate        = self;
        view.dataSource      = self;
        view.separatorStyle  = UITableViewCellSeparatorStyleNone;
        view.estimatedRowHeight           = 0.0f;
        view.estimatedSectionFooterHeight = 0.0f;
        view.estimatedSectionHeaderHeight = 0.0f;
        view.tableHeaderView              = self.headerDetailView;
        [view registerClass:UITableViewCell.class        forCellReuseIdentifier:KKWebViewTableCellIdentifier];
        [view registerClass:KKNewsCommentTableCell.class forCellReuseIdentifier:KKNewsCommentTableCellIdentifier];

        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationBar.mas_bottom).priorityLow();
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
        }];
        view;
    });
    
    self.bottomBarView = ({
        KKDragableBottomBarView *view = [[KKDragableBottomBarView alloc] initWithBarType:KKBottomBarTypeNewsDetailComment];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(view.superview.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.equalTo(view.superview.mas_bottom);
            }
            make.top.equalTo(self.tableView.mas_bottom);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(CGFloatPixelRound(44.0f));
        }];
        view;
    });
    
    self.scrollView = ({
        UIScrollView *view = UIScrollView.alloc.init;
        view.showsVerticalScrollIndicator   = false;
        view.showsHorizontalScrollIndicator = false;
        view.bounces = false;
        view.delegate = self;
        view;
    });
    
    self.webView = ({
        WKWebViewConfiguration *configurate = WKWebViewConfiguration.alloc.init;
        WKUserContentController *userVC     = WKUserContentController.alloc.init;
        // 自适应屏幕宽度js、禁止缩放
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no');\
        document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *userVCScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:true];
        // 添加js调用
        [userVC addUserScript:userVCScript];
        configurate.userContentController             = userVC;
        configurate.suppressesIncrementalRendering    = true;
        if (@available(iOS 9.0, *)) {
            configurate.allowsAirPlayForMediaPlayback = true;
        }
        configurate.allowsInlineMediaPlayback         = true;
        configurate.selectionGranularity              = true;
        DWKWebView *view = [[DWKWebView alloc] initWithFrame:CGRectZero configuration:configurate];
        
        view.allowsBackForwardNavigationGestures = true;
        view.userInteractionEnabled = true;
        view.scrollView.delegate    = self;
        view.scrollView.bounces     = false;
        view.navigationDelegate     = self;
        view.DSUIDelegate           = self;
        [view addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [view addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [view.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
        [view sizeToFit];
        [self.scrollView addSubview:view];
        view;
    });
    

    self.webURLString = @"http://world.people.com.cn/n1/2019/0702/c1002-31207007.html";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURLString]]];
}


-(void)viewWillAppear{
    [super viewWillAppear];
}

-(void)viewDidAppear{
    [super viewDidAppear];
    self.headerDetailView.title = @"泛彼柏舟，亦泛其流。耿耿不寐，如有隐忧。微我无酒，以敖以游。\
    我心匪鉴，不可以茹。亦有兄弟，不可以据。薄言往诉，逢彼之怒。\
    我心匪石，不可转也。我心匪席，不可卷也。威仪棣棣，不可选也。\
    忧心悄悄，愠于群小。觏闵既多，受侮不少。静言思之，寤辟有摽。\
    日居月诸，胡迭而微？心之忧矣，如匪浣衣。静言思之，不能奋飞。";
}

-(void)viewWillDisappear{
    [super viewWillDisappear];
}

-(void)viewDidDisappear{
    [super viewDidDisappear];
}


-(void)dragBeginWithPoint:(CGPoint)pt{
    [super dragBeginWithPoint:pt];
}

-(void)dragingWithPoint:(CGPoint)pt{
    [super dragingWithPoint:pt];
    self.tableView.scrollEnabled = false;
    self.webView.scrollView.scrollEnabled = false;
}

- (void)dragEndWithPoint:(CGPoint)pt shouldHideView:(BOOL)hideView{
    [super dragingWithPoint:pt];
    self.tableView.scrollEnabled = true;
    self.webView.scrollView.scrollEnabled = true;
}


#pragma mark -
#pragma mark - Observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        UIScrollView *scrollView = (UIScrollView *)object;
        self.webViewHeight    = scrollView.contentSize.height;
        self.webView.frame    = CGRectMake(0, 0, KKScreenWidth(), self.webViewHeight);
        self.scrollView.frame = CGRectMake(0, 0, KKScreenWidth(), self.webViewHeight);
        self.scrollView.contentSize = CGSizeMake(KKScreenWidth(), self.webViewHeight);
        [self.tableView reloadData];
    }else if ([object isKindOfClass:WKWebView.class] && [keyPath isEqualToString:@"title"]){
//        self.navigationBar.title = [change objectForKey:NSKeyValueChangeNewKey];
    }else if ([object isKindOfClass:WKWebView.class] && [keyPath isEqualToString:@"estimatedProgress"]){
        CGFloat progess = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        NSLog(@"progess-------%0.2f",progess);
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark -
#pragma mark - WKUIDelegate/WKNavigationDelegate
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.tableView setHidden:true];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.tableView setHidden:false];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载失败....");
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (navigationAction.targetFrame.isMainFrame == false) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

// 接收到服务器跳转请求之后调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 在收到响应后，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    //WKWebView默认屏蔽外部链接跳转,需要手动开启
    NSURL *url = navigationAction.request.URL;
    if ([url.absoluteString isEqualToString:@"itunes.apple.com"]) {
        UIApplication *app = UIApplication.sharedApplication;
        if ([app canOpenURL:url]) {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark -
#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:KKWebViewTableCellIdentifier];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:KKNewsCommentTableCellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.scrollView];
    }
    if (indexPath.section == 1) {
        KKNewsCommentTableCell *commentCell = (KKNewsCommentTableCell *)cell;
        commentCell.backgroundColor = UIColor.randomColor;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.webViewHeight;
    }
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY----------%.2f",offsetY);
    if (offsetY >= self.headerDetailView.height) {
        
    }else{
        
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
