//
//  KKLanuchViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLanuchViewController.h"
#import "AppDelegate.h"


@interface KKLanuchViewController ()

@property (nonatomic,strong) UIActivityIndicatorView *loadingView;

    
@end

@implementation KKLanuchViewController

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navigationBar.hidden = true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_addSubviews{
    [super kk_addSubviews];
    self.loadingView = ({
        UIActivityIndicatorView *view = UIActivityIndicatorView.alloc.init;
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        view.color = [UIColor colorWithHexString:@"#207CB7"];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.superview.mas_centerX);
            make.centerY.equalTo(view.superview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        view;
    });
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    [self.loadingView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingView stopAnimating];
        [KKErrorHelper kk_enterApp];
    });
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
