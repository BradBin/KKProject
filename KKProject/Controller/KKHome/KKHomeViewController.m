//
//  KKHomeViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "KKHomePageViewController.h"

@interface KKHomeViewController ()<JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate>

@property (nonatomic,strong) JXCategoryTitleView         *categoryView;
@property (nonatomic,strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic,strong) NSArray *categoryTitles;

@end

@implementation KKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navShadowImage       = UIImage.new;
    self.kk_navShadowColor       = [UIColor colorWithHexString:@"#EFEFEF"];
    self.kk_navigationBar.hidden = true;
}

-(void)kk_addSubviews{
    [super kk_addSubviews];
    self.categoryView = ({
        JXCategoryTitleView *view      = JXCategoryTitleView.alloc.init;
        view.averageCellSpacingEnabled = false;
        view.delegate                  = self;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top).offset(_kk_status_height());
            make.left.equalTo(view.superview.mas_left);
            make.width.equalTo(view.superview.mas_width).multipliedBy(0.9);
            make.height.mas_equalTo(50);
        }];
        view;
    });
    
    self.listContainerView = ({
        JXCategoryListContainerView *view = [[JXCategoryListContainerView alloc] initWithDelegate:self];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.categoryView.mas_bottom);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.bottom.equalTo(view.superview.mas_bottom);
        }];
        view;
    });
    
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    [self kk_categoryReloadData];
}


/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)kk_categoryReloadData {
    
    //重载之后默认回到0，你也可以指定一个index
    self.categoryView.defaultSelectedIndex = 1;
    self.categoryView.titles = self.categoryTitles;
    [self.categoryView reloadData];
    
    self.listContainerView.defaultSelectedIndex = 1;
    [self.listContainerView reloadData];
}


#pragma mark -
#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    KKHomePageViewController *listVC = [[KKHomePageViewController alloc] init];
    return listVC;
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



#pragma mark -
#pragma mark - initialize instance

- (NSArray *)categoryTitles{
    if (_categoryTitles == nil) {
        _categoryTitles = @[@"1",@"2"];
    }
    return _categoryTitles;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
