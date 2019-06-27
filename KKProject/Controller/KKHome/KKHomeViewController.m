//
//  KKHomeViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "KKChannelView.h"
#import "KKHomeView.h"
#import "KKHomeViewModel.h"
#import "KKTextField.h"
#import "KKShareView.h"

@interface KKHomeViewController ()<JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate>
@property (nonatomic,strong) KKHomeViewModel             *viewModel;
@property (nonatomic,strong) UIView                      *maskView;
@property (nonatomic,strong) CAGradientLayer             *maskLayer;
@property (nonatomic,strong) UIButton                    *editBtn;
@property (nonatomic,strong) KKTextField                 *textfieldBar;
@property (nonatomic,strong) JXCategoryTitleView         *categoryView;
@property (nonatomic,strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic,strong) NSArray                     *categoryTitles;

@end

@implementation KKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navShadowImage       = UIImage.new;
    self.kk_navShadowColor       = UIColor.clearColor;
    self.kk_navigationBar.hidden = true;
}


-(void)kk_addSubviews{
    [super kk_addSubviews];
    
    self.maskView = ({
        UIView *view = UIView.alloc.init;
        [self.view addSubview:view];
        [self.view insertSubview:view atIndex:0];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(CGFloatPixelRound(_kk_nav_height() + 50));
        }];
        [view.superview layoutIfNeeded];
        view;
    });
    
    self.maskLayer = ({
        CAGradientLayer *layer = CAGradientLayer.layer;
        layer.frame            = self.maskView.bounds;
        layer.colors           = @[(__bridge id)[UIColor colorWithHexString:@"#F30E3B"].CGColor,
                                   (__bridge id)[UIColor colorWithHexString:@"#F50015"].CGColor,
                                   (__bridge id)[UIColor colorWithHexString:@"#FFFFFF"].CGColor];
        layer.locations        = @[@0.25, @0.50];
        layer.startPoint       = CGPointMake(0, 0);
        layer.endPoint         = CGPointMake(0, 1);
        [self.maskView.layer insertSublayer:layer atIndex:0];
        layer;
    });
    
    self.textfieldBar = ({
        KKTextField *textfield        = KKTextField.alloc.init;
        textfield.backgroundColor     = UIColor.whiteColor;
        textfield.layer.masksToBounds = true;
        textfield.layer.cornerRadius  = CGFloatPixelRound(5.0f);
        NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc]
                                                            initWithString:@"请输入感兴趣..."
                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]}];
        textfield.attributedPlaceholder = attributedPlaceholder;
        textfield.font = [UIFont systemFontOfSize:15.f];
        [self.view addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            UIEdgeInsets insets = UIEdgeInsetsMake(_kk_status_height() + 5.0,
                                                   16, 0, -60);
            make.top.equalTo(textfield.superview.mas_top).offset(insets.top);
            make.left.equalTo(textfield.superview.mas_left).offset(insets.left);
            make.right.equalTo(textfield.superview.mas_right).offset(insets.right);
            make.height.mas_equalTo(@40);
        }];
        textfield;
    });
    
    self.editBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"home_edit.png"] forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.textfieldBar.mas_centerY);
            make.left.equalTo(self.textfieldBar.mas_right).offset(8);
            make.right.equalTo(button.superview.mas_right).offset(-16);
            make.height.equalTo(self.textfieldBar.mas_height);
        }];
        button;
    });
    
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
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textfieldBar.mas_bottom).offset(4);
            make.left.equalTo(view.superview.mas_left);
            make.width.equalTo(view.superview.mas_width).multipliedBy(1.0);
            make.height.mas_equalTo(44);
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
    
    [self kk_categoryReloadData];
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    @weakify(self);
    [[[self.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
//        [[[KKChannelView kk_channelViewWithViewModel:self.viewModel] kk_updateConfigure:^(KKChannelView * _Nonnull channelView) {
//            channelView.contentView.backgroundColor = UIColor.redColor;
//            channelView.titlelabel.text = @"fasasfaffa";
//            channelView.titlelabel.numberOfLines = 0;
//            channelView.closeBtn.backgroundColor = UIColor.orangeColor;
//            channelView.showDuration             = 5;
//        }] kk_showBlock:^{
//             NSLog(@"kk_showBlock");
//        } hideBlock:^{
//            NSLog(@"kk_hideBlock");
//        }];
        [KKShareView.shared kk_shareWithItems:nil functions:nil showBlock:^{
            NSLog(@"kk_showBlock");
        } hideBlock:^{
             NSLog(@"kk_hideBlock");
        }];
    }];
    
    [[self.viewModel.categoryUISubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:NSArray.class]) {
            self.categoryTitles = [self geTitlestWithModelArray:(NSArray *)x];
            [self kk_categoryReloadData];
        }else if([x isKindOfClass:NSNumber.class]){
            
        }else{
            
        }
    }];
    
    [[self.viewModel.refreshCategoryBackUISubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:UIColor.class]) {
            UIColor *color = (UIColor *)x;
            self.maskLayer.colors  = @[(__bridge id)[UIColor colorWithHexString:@"#F30E3B"].CGColor,
                                       (__bridge id)color.CGColor,
                                       (__bridge id)[UIColor colorWithHexString:@"#FFFFFF"].CGColor];
        }
    }];
    
    //HomePage事件响应 push VC
    [[self.viewModel.pushVCSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:KKViewController.class]) {
            [self.navigationController pushViewController:(KKViewController *)x animated:true];
        }
    }];

     //HomePage事件响应 present VC
    [[self.viewModel.presentVCSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:KKViewController.class]) {
            [self presentViewController:(KKViewController *)x animated:true completion:nil];
        }
    }];
    
}

/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)kk_categoryReloadData {
    
    self.categoryView.contentScrollView    = self.listContainerView.scrollView;
    self.categoryView.defaultSelectedIndex = 1;
    self.categoryView.titles               = self.categoryTitles;
    [self.categoryView reloadData];
    
    self.listContainerView.defaultSelectedIndex = 1;
    [self.listContainerView reloadData];
}

#pragma mark -
#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    KKHomeView *listView = [[KKHomeView alloc] initWithViewModel:self.viewModel];
    listView.categoryModel             = self.viewModel.categoryTitles[index];
    return listView;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryTitles.count;
}

#pragma mark -
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    //NSLog(@"didClickSelectedItemAtIndex-----%ld",index);
    [self.listContainerView didClickSelectedItemAtIndex:index];
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index{
    //NSLog(@"didScrollSelectedItemAtIndex-----%ld",index);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark -
#pragma mark - Private method
/**
 获取类型标题数据源
 */
- (NSArray *)geTitlestWithModelArray:(NSArray *)array {
    NSMutableArray *results = NSMutableArray.array;
    for (KKHomeCategoryTitleModel *model in array) {
        [results addObject:model.name];
    }
    return results;
}
#pragma mark -
#pragma mark - initialize instance


- (KKHomeViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = KKHomeViewModel.alloc.init;
    }
    return _viewModel;
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
