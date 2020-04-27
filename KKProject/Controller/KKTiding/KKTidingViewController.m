//
//  KKTidingViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/4.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTidingViewController.h"
#import "KKTidingView.h"

@interface KKTidingViewController ()

@property (nonatomic, strong) KKTidingViewModel *viewModel;
@property (nonatomic, strong) KKTidingView       *tidingView;

@end

@implementation KKTidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navShadowImage = UIImage.new;
    self.kk_navShadowColor = [UIColor colorWithHexString:@"#EFEFEF"];
    self.kk_navTitle       = @"消息";
}

-(void)kk_addSubviews{
    [super kk_addSubviews];
    
    self.tidingView = ({
        KKTidingView *view = [[KKTidingView alloc] initWithViewModel:self.viewModel];
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

-(KKTidingViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = KKTidingViewModel.new;
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
