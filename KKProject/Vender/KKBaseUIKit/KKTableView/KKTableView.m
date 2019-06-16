//
//  KKTableView.m
//  ot-dayu
//
//  Created by 尤彬 on 2019/1/11.
//  Copyright © 2019 YangCK. All rights reserved.
//

#import "KKTableView.h"
#import "AppDelegate.h"


@implementation KKTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    return  [super init];
}

- (void) commitInit{
    self.placerText = @" ";
    [self _kk_commitInit];
    [self kk_setupView];
    [self kk_setupConfig];
    [self kk_bindViewModel];
}

-(void)kk_bindViewModel{}

- (void)kk_setupView{}

- (void)kk_setupConfig{}

-(void)kk_addReturnKeyBoard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapAction)];
    tap.numberOfTapsRequired    = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void) tapAction{
    AppDelegate *app = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [app.window endEditing:true];
}

- (void) _kk_commitInit{
    self.loading = false;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.tableView.superview).insets(self.safeAreaInsets);
        } else {
            make.edges.equalTo(self.tableView.superview);
        }
    }];
}


-(_KKTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[_KKTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight             = 0;
        _tableView.estimatedSectionHeaderHeight   = 0;
        _tableView.estimatedSectionFooterHeight   = 0;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = false;
        }
    return _tableView;
}



#pragma mark- UITableViewDelegate/UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * const kkTableIdentifier = @"kk.Table.Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kkTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kkTableIdentifier];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true ];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = UIView.alloc.init;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = UIView.alloc.init;
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end




@implementation _KKTableView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delaysContentTouches    = NO;
        self.canCancelContentTouches = YES;
        self.separatorStyle          = UITableViewCellSeparatorStyleNone;
        // Remove touch delay (since iOS 8)
        UIView *wrapView             = self.subviews.firstObject;
        // UITableViewWrapperView
        if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
            for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
                // UIScrollViewDelayedTouchesBeganGestureRecognizer
                if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
                    gesture.enabled = NO;
                    break;
                }
            }
        }
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]])  return YES;
    return [super touchesShouldCancelInContentView:view];
}

@end