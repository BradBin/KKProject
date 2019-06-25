//
//  KKSettingsViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/16.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKSettingsViewController.h"
#import "KKSettingsView.h"
#import "KKLanguageHelper.h"

@interface KKSettingsViewController ()
@property (nonatomic,strong) KKSettingsViewModel *viewModel;
@property (nonatomic,strong) KKSettingsView      *settingsView;

@end

@implementation KKSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 系统语言
 */
- (void)setupLanguage{
    KKLanguageHelper *helper = KKLanguageHelper.shared;
    NSLog(@"系统语言------%@  ---- %ld",helper.language,helper.languageType);
}


- (void)kk_logOutEvent:(UIBarButtonItem *)item{

    [KKErrorHelper kk_showLoginVCWithBlock:^(UIViewController * _Nonnull vc) {
        [vc.view showTitle:@"欢迎来到登录界面"];
        [KKAccountHelper.shared kk_logOut];
    }];
}

- (void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navShadowImage     = UIImage.new;
    self.kk_navShadowColor     = [UIColor colorWithHexString:@"#EFEFEF"];
    self.kk_navBackgroundColor = UIColor.clearColor;
    self.kk_navTitle           = @"Profile";
    self.kk_navRightBarButtonItem = [UIBarButtonItem kk_itemWithTitle:@"退出"
                                                           titleColor:[UIColor colorWithHexString:@"#5B5B5B"]
                                                            imageName:nil
                                                        highImageName:nil
                                                               target:self
                                                               action:@selector(kk_logOutEvent:)];
}


-(void)kk_addSubviews{
    [super kk_addSubviews];
    self.settingsView = ({
        KKSettingsView *view = [[KKSettingsView alloc] initWithViewModel:self.viewModel];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kk_navigationBar.mas_bottom);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.bottom.equalTo(view.superview.mas_bottom);
        }];
        view;
    });
}


-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    //系统语言
    [self setupLanguage];
}

-(KKSettingsViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = KKSettingsViewModel.alloc.init;
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
