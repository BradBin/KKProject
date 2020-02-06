//
//  KKTableView.m
//  ot-dayu
//
//  Created by 尤彬 on 2019/1/11.
//  Copyright © 2019 YangCK. All rights reserved.
//

#import "KKTableView.h"
#import "AppDelegate.h"

@interface KKTableView ()

@property (nonatomic,strong) _KKTableView *plainTableView;
@property (nonatomic,strong) _KKTableView *groupTableView;

@end


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
    [self addSubview:self.refreshTipLabel];
    [self insertSubview:self.refreshTipLabel aboveSubview:self.tableView];
    [self.refreshTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.refreshTipLabel.superview.mas_top);
        make.centerX.equalTo(self.refreshTipLabel.superview.mas_centerX);
        make.width.equalTo(self.refreshTipLabel.superview.mas_width);
        make.height.mas_equalTo(CGFloatPixelRound(30.0f));
    }];
    
    self.tableView = self.plainTableView;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.tableView.superview).insets(self.safeAreaInsets);
        } else {
            make.edges.equalTo(self.tableView.superview);
        }
    }];
}

-(void)kk_setTableViewStyle:(UITableViewStyle)tableViewStyle{
    if (tableViewStyle == UITableViewStylePlain) {
        if (self.plainTableView.superview) {
            
        }else{
            if (self.groupTableView.superview) {
                [self.groupTableView removeFromSuperview];
            }
            self.tableView = self.plainTableView;
            [self addSubview:self.tableView];
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.edges.equalTo(self.tableView.superview).insets(self.safeAreaInsets);
                } else {
                    make.edges.equalTo(self.tableView.superview);
                }
            }];
        }
    }else{
        if (self.groupTableView.superview) {
            
        }else{
            if (self.plainTableView.superview) {
                [self.plainTableView removeFromSuperview];
            }
            self.tableView = self.groupTableView;
            [self addSubview:self.tableView];
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.edges.equalTo(self.tableView.superview).insets(self.safeAreaInsets);
                } else {
                    make.edges.equalTo(self.tableView.superview);
                }
            }];
        }
    }
}


-(_KKTableView *)plainTableView{
    if (_plainTableView == nil) {
        _plainTableView = [[_KKTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _plainTableView.delegate                       = self;
        _plainTableView.dataSource                     = self;
        _plainTableView.estimatedRowHeight             = 0;
        _plainTableView.estimatedSectionHeaderHeight   = 0;
        _plainTableView.estimatedSectionFooterHeight   = 0;
        _plainTableView.emptyDataSetSource             = self;
        _plainTableView.emptyDataSetDelegate           = self;
        _plainTableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _plainTableView.showsHorizontalScrollIndicator = false;
    }
    return _plainTableView;
}

-(_KKTableView *)groupTableView{
    if (_groupTableView == nil) {
        _groupTableView = [[_KKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _groupTableView.delegate                       = self;
        _groupTableView.dataSource                     = self;
        _groupTableView.estimatedRowHeight             = 0;
        _groupTableView.estimatedSectionHeaderHeight   = 0;
        _groupTableView.estimatedSectionFooterHeight   = 0;
        _groupTableView.emptyDataSetSource             = self;
        _groupTableView.emptyDataSetDelegate           = self;
        _groupTableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _groupTableView.showsHorizontalScrollIndicator = false;
    }
    return _groupTableView;
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


-(UILabel *)refreshTipLabel{
    if (_refreshTipLabel == nil) {
        _refreshTipLabel = UILabel.new;
        _refreshTipLabel.backgroundColor = [UIColor colorWithRed:214/255.0 green:232/255.0 blue:248/255.0 alpha:1.0];
        _refreshTipLabel.textColor       = [UIColor colorWithRed:0/255.0   green:135/255.0 blue:211/255.0 alpha:1.0];
        _refreshTipLabel.font            = [UIFont systemFontOfSize:15];
        _refreshTipLabel.textAlignment   = NSTextAlignmentCenter;
        //        _refreshTipLabel.hidden          = true;
    }
    return _refreshTipLabel;
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
