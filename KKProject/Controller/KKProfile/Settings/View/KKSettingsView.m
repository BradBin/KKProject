//
//  KKSettingsView.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKSettingsView.h"
#import "KKSettingsTableCell.h"

@interface KKSettingsView ()
@property (nonatomic,strong) KKSettingsViewModel *viewModel;

@end

@implementation KKSettingsView

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    _viewModel = viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)kk_setupView{
    [super kk_setupView];
    self.tableView.separatorColor = KKDefaultBackgroundViewColor();
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight      = CGFloatPixelRound(44.0f);
}

- (void)kk_bindViewModel{
    [super kk_bindViewModel];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(NSArray *)self.viewModel.dataSources[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.viewModel.dataSources[indexPath.section][indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:dict[KKCellIdentifier] forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = ((NSArray *)self.viewModel.dataSources[indexPath.section])[indexPath.row];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
