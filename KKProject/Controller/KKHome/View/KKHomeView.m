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

@end
@implementation KKHomeView

- (UIView *)listView {
    return self;
}

//可选使用，列表显示的时候调用
- (void)listDidAppear {
    if (self.viewModel.homePageVM.pageDatas.count == 0) {
        self.viewModel.homePageVM.categoryModel = self.categoryModel;
        [self.viewModel.homePageVM.refreshCommand execute:@(true)];
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
    
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    dispatch_async_on_main_queue(^{
        [self.tableView reloadData];
    });
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
//    KKWebViewController *vc = [[KKWebViewController alloc] initWithURLString:@"https://www.baidu.com" webApis:nil];
//    [self.viewModel.homePageVM.pushVCSubject sendNext:vc];
//    [self.viewModel.homePageVM.presentVCSubject sendNext:vc];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
