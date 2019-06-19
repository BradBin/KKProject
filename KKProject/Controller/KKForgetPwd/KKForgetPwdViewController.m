//
//  KKForgetPwdViewController.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/14.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKForgetPwdViewController.h"

@interface KKForgetPwdViewController ()

@end

@implementation KKForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navShadowColor = [UIColor clearColor];
    self.kk_navShadowImage = [UIImage new];
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
