//
//  KKURLSessionView.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/17.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKURLSessionView.h"
#import <JXCategoryView/JXCategoryView.h>

#import "KKURLSessionView_Normal.h"
#import "KKURLSessionView_Upload.h"
#import "KKURLSessionView_Download.h"
#import "KKURLSessionView_offlineDown.h"


@interface KKURLSessionView ()<JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView         *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray                     *categoryTitles;

@end

@implementation KKURLSessionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self kk_categoryReloadData];
    }
    return self;
}

-(void)setupView{
    self.categoryView = ({
        JXCategoryTitleView *view      = JXCategoryTitleView.alloc.init;
        view.averageCellSpacingEnabled = false;
        view.delegate                  = self;
        view.titleColor                = [UIColor colorWithHexString:@"#5B5B5B"];
        view.titleSelectedColor        = [UIColor colorWithHexString:@"#1B1B1B"];
        view.titleLabelZoomScale       = 1.35;
        view.titleLabelZoomEnabled     = true;
        view.titleColorGradientEnabled = true;
        view.titleFont                 = [UIFont systemFontOfSize:16.5];
        view.averageCellSpacingEnabled = true;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview);
            make.left.equalTo(view.superview);
            make.right.equalTo(view.superview);
            make.height.mas_equalTo(44);
        }];
        view;
    });
    
    self.listContainerView = ({
        JXCategoryListContainerView *view = [[JXCategoryListContainerView alloc]initWithDelegate:self];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.categoryView.mas_bottom);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.bottom.equalTo(view.superview.mas_bottom);
        }];
        view;
    });
}

- (void)kk_categoryReloadData {
    
    self.categoryView.contentScrollView    = self.listContainerView.scrollView;
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titles               = self.categoryTitles;
    [self.categoryView reloadData];
    
    self.listContainerView.defaultSelectedIndex = 0;
    [self.listContainerView reloadData];
}

#pragma mark -
#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            return KKURLSessionView_Normal.new;
            break;
        case 1:
            return KKURLSessionView_Upload.new;
        case 2:
            return KKURLSessionView_Download.new;
            break;
        case 3:
            return KKURLSessionView_offlineDown.new;
            break;
        default:
            return KKURLSessionBaseView.new;
            break;
    }
    
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryTitles.count;
}

#pragma mark -
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - Lazy Instance
-(NSArray *)categoryTitles{
    if (_categoryTitles == nil) {
        _categoryTitles = [NSArray arrayWithObjects:@"普通请求",@"上传数据",@"下载数据",@"离线下载数据", nil];
    }
    return _categoryTitles;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
