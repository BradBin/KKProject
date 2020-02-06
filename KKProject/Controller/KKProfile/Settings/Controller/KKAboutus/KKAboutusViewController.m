//
//  KKAboutusViewController.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKAboutusViewController.h"
#import "KKAboutusView.h"

@interface KKAboutusViewController ()

@property (nonatomic, strong) KKAboutusViewModel *viewModel;
@property (nonatomic, strong) KKAboutusView *aboutusView;

@end

@implementation KKAboutusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navBackgroundColor = UIColor.clearColor;
    self.kk_navTintColor       = [UIColor colorWithHexString:@"#FC3E4B"];
}

-(void)kk_addSubviews{
    [super kk_addSubviews];
    self.aboutusView = ({
        KKAboutusView *view = [[KKAboutusView alloc] initWithViewModel:self.viewModel];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view.superview);
        }];
        [view.superview layoutIfNeeded];
        view;
    });
}


-(KKAboutusViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = KKAboutusViewModel.new;
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
