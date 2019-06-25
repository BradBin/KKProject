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
    self.tableView.separatorColor  = KKDefaultBackgroundViewColor();
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight       = CGFloatPixelRound(44.0f);
    self.tableView.backgroundColor = KKDefaultBackgroundViewColor();
    [self.tableView registerClass:KKContentTableCell.class   forCellReuseIdentifier:KKRightLabelCellIdentifier];
    [self.tableView registerClass:KKSettingsTableCell.class  forCellReuseIdentifier:KKRightViewCellIdentifier];
    [self.tableView registerClass:KKTextFieldTableCell.class forCellReuseIdentifier:KKTextFieldCellIdentifier];

}

- (void)kk_bindViewModel{
    [super kk_bindViewModel];
    @weakify(self);
    [[self.viewModel.cleanSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [UIView showTitle:@"clean cache"];
    }];
    
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
    NSDictionary *dict = ((NSArray *)self.viewModel.dataSources[indexPath.section])[indexPath.row];
    KKSettingsTableCell *settingsCell = (KKSettingsTableCell *)cell;
    
    [settingsCell kk_showArrow:[[dict objectForKey:KKNeedArrow] boolValue]];
    
    NSString *cellIdentifier = [dict objectForKey:KKCellIdentifier];
    if ([cellIdentifier isEqualToString:KKRightLabelCellIdentifier]) {
        KKContentTableCell *labelCell = (KKContentTableCell *)cell;
        [labelCell kk_setTitle:dict[KKTitle] subTitle:dict[KKDesc]];
    }else if ([cellIdentifier isEqualToString:KKRightViewCellIdentifier]){
        [settingsCell kk_setImage:nil title:dict[KKTitle]];
    }else{
        KKTextFieldTableCell *textfieldCell = (KKTextFieldTableCell *)cell;
        [textfieldCell kk_setImage:[UIImage imageNamed:@"fishpond_highlight.png"] title:dict[KKTitle]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSDictionary *dict = ((NSArray *)self.viewModel.dataSources[indexPath.section])[indexPath.row];

    if ([dict objectForKey:KKClickAction]) {
        void(^action)(void) = [dict objectForKey:KKClickAction];
        action();
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = UIView.alloc.init;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = UIView.alloc.init;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
