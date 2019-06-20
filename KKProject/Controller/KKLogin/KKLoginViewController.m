//
//  KKLoginViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLoginViewController.h"
#import "KKLoginView.h"

@interface KKLoginViewController ()
@property (nonatomic,strong) KKLoginView *loginView;
@property (nonatomic,strong) KKLoginViewModel *viewModel;

@end

@implementation KKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navigationBar.hidden = true;
}

-(void)kk_addSubviews{
    [super kk_addSubviews];
    
    self.loginView = ({
        KKLoginView *view = [[KKLoginView alloc] initWithViewModel:self.viewModel];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            UIEdgeInsets insets = UIEdgeInsetsZero;
            if (@available(iOS 11.0, *)) {
                insets = UIApplication.sharedApplication.keyWindow.safeAreaInsets;
            }
            make.edges.equalTo(view.superview).insets(insets);
        }];
        view;
    });
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    [[self.viewModel.pushVCSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:KKViewController.class]) {
            [self.navigationController pushViewController:(KKViewController *)x animated:true];
        }else{
            [KKErrorHelper kk_showHomeVCWithBlock:^(UIViewController * _Nonnull vc) {
                [KKAccountHelper.shared kk_logIn];
                [vc.view showTitle:@"欢迎来到xxx"];
            }];
        }
    }];
}

-(KKLoginViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = KKLoginViewModel.alloc.init;
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
