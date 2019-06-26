//
//  KKSettingsView.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKSettingsView.h"
#import "KKSettingsTableCell.h"
#import "KKCacheHelper.h"

@interface KKSettingsView ()
@property (nonatomic,strong) KKSettingsViewModel *viewModel;
@property (nonatomic,strong) UISwitch            *autoPlayWithWiFi;

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
    [[[self.autoPlayWithWiFi rac_newOnChannel] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        NSLog(@"autoPlayWithWiFi---------------%@",x);
    }];
    
    [[self.viewModel.changeLanguageSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"多语言---------------%@",x);
    }];
    
    //缓存处理
    [[self.viewModel.cleanSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:NSNumber.class]) {
            KKCacheType type = (KKCacheType )[(NSNumber *)x unsignedIntegerValue];
            switch (type) {
                case KKCacheTypeChatRecord:
                    [UIView showTitle:@"clean the cache of chat record"];
                    break;
                    
                case KKCacheTypeImageCache:{
                    [KKCacheHelper.shared cleanImageCache:^(CGFloat progress, NSUInteger removedCount, NSUInteger totalCount) {
                        NSLog(@"-------%lf  %ld  %ld",progress,removedCount,totalCount);
                    } completion:^(BOOL error) {
                        if (error) {
                            [UIView showError:@"清空缓存失败!"];
                        }else{
                            [UIView showSuccess:@"清空缓存成功!"];
                            [self.tableView reloadData];
                        }
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }
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
    
    NSString *title = [dict objectForKey:KKTitle];
    if ([title containsString:@"WiFi"]) {
        settingsCell.rightView = self.autoPlayWithWiFi;
    }else if ([title containsString:@"缓存"]){
        ((YYLabel *)settingsCell.rightView).text = [NSString stringWithFormat:@"%.2fM",[KKCacheHelper.shared imageCache]];
    }else if ([title containsString:@"聊天"]){
        ((YYLabel *)settingsCell.rightView).text = [NSString stringWithFormat:@"%.2fM",KKCacheHelper.shared.imageCacheSize];
    }else{}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSDictionary *dict = ((NSArray *)self.viewModel.dataSources[indexPath.section])[indexPath.row];
    
    if (dict[KKNextVCClass]) {
         NSString *className = dict[KKNextVCClass];
        Class class = NSClassFromString(className);
        if (class) {
             [self.viewModel.pushVCSubject sendNext:[[class alloc] init]];
        }
    }else if ([dict objectForKey:KKClickAction]) {
        void(^action)(void) = [dict objectForKey:KKClickAction];
        action();
    }else{
        
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



- (UISwitch *)autoPlayWithWiFi{
    if (_autoPlayWithWiFi == nil) {
        _autoPlayWithWiFi           = UISwitch.alloc.init;
        _autoPlayWithWiFi.transform = CGAffineTransformMakeScale(0.75, 0.75);
    }
    return _autoPlayWithWiFi;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
