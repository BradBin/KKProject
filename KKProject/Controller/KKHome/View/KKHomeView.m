//
//  KKHomeView.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/19.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeView.h"
#import "KKHomeViewCell.h"
#import "KKWebViewController.h"

@interface KKHomeView ()
@property (nonatomic,strong) KKHomeViewModel *viewModel;
@property (nonatomic,strong) KKHomePageViewModel *pageViewModel;

@end
@implementation KKHomeView

- (UIView *)listView {
    return self;
}

//可选使用，列表显示的时候调用
- (void)listDidAppear {
    if (self.pageViewModel.homeLayouts.count == 0) {
        self.pageViewModel.categoryModel = self.categoryModel;
        [self.pageViewModel.refreshCommand execute:@(true)];
        UIColor *categoryBackUIColor;
        if ([self.categoryModel.name isEqualToString:@"北京"]) {
            categoryBackUIColor = [UIColor colorWithHexString:@"#D64D31"];
        }else if ([self.categoryModel.name isEqualToString:@"图片"]){
            categoryBackUIColor = [UIColor colorWithHexString:@"#FC2E1F"];
        }else{
            categoryBackUIColor = [UIColor colorWithHexString:@"#F50015"];
        }
        [self.viewModel.refreshCategoryBackUISubject sendNext:categoryBackUIColor];
    }
}

//可选使用，列表消失的时候调用
- (void)listDidDisappear {
    
}


- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    _viewModel = viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)kk_setupView{
    [super kk_setupView];
    [self.tableView.backgroundView removeFromSuperview];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [self.tableView registerClass:KKHomeViewCell.class forCellReuseIdentifier:KKHomeViewCellIdentifier];
    
    @weakify(self);
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.pageViewModel.refreshCommand execute:@(true)];
    }];
    self.tableView.mj_header = mjHeader;
    
     MJRefreshAutoGifFooter *mjFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.pageViewModel.nextRefreshCommand execute:@(true)];
    }];
    self.tableView.mj_footer = mjFooter;
    
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
   
    @weakify(self);
    [[self.pageViewModel.refreshUISubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:NSNumber.class] == false) return ;
        KKRefreshStatus status = (KKRefreshStatus)[x unsignedIntegerValue];
        switch (status) {
            case KKRefreshStatusDataUnexpect_Header:
                [self.tableView.mj_header endRefreshing];
                break;
                
            case KKRefreshStatusDataUnexpect_Footer:
                [self.tableView.mj_footer endRefreshing];
                break;
                
            case KKRefreshStatusNetworkError_Header:
                [self.tableView.mj_header endRefreshing];
                break;
                
            case KKRefreshStatusNetworkError_Footer:
                [self.tableView.mj_footer endRefreshing];
                break;
                
            case KKRefreshStatusNoMoreData_Header:
                [self.tableView.mj_header endRefreshing];
                break;
                
            case KKRefreshStatusMoreData_Header:
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_header endRefreshing];
                break;
                
            case KKRefreshStatusNoMoreData_Footer:
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                break;
                
            case KKRefreshStatusMoreData_Footer:
                [self.tableView.mj_footer endRefreshing];
                break;
                
            default:
                break;
        }
        dispatch_async_on_main_queue(^{
            [self.tableView reloadData];
        });
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:KKHomeViewCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    KKHomeViewCell *pageCell = (KKHomeViewCell *)cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KKWebViewController *vc = [[KKWebViewController alloc] initWithURLString:@"https://www.baidu.com" webApis:nil];
//    [self.viewModel.pushVCSubject sendNext:vc];
//    [self.viewModel.presentVCSubject sendNext:vc];
}

-(KKHomePageViewModel *)pageViewModel{
    if (_pageViewModel == nil) {
        _pageViewModel = KKHomePageViewModel.alloc.init;
    }
    return _pageViewModel;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
