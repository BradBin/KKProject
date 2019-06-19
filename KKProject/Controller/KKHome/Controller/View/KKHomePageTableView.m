//
//  KKHomePageTableView.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/19.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomePageTableView.h"
#import "KKHomePageTableCell.h"

@interface KKHomePageTableView ()
@property (nonatomic,strong) KKHomePageViewModel *viewModel;

@end
@implementation KKHomePageTableView

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    _viewModel = viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)kk_setupView{
    [super kk_setupView];
    [self.tableView.backgroundView removeFromSuperview];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [self.tableView registerClass:KKHomePageTableCell.class forCellReuseIdentifier:KKHomePageTableCellIdentifier];
   
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
    return [tableView dequeueReusableCellWithIdentifier:KKHomePageTableCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    KKHomePageTableCell *pageCell = (KKHomePageTableCell *)cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
