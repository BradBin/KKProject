//
//  KKProfileViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKProfileViewController.h"
#import "KKSettingsViewController.h"

@interface KKProfileViewController ()


@end

@implementation KKProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)kk_settingsEvent:(UIBarButtonItem *)item{
    KKSettingsViewController *vc = KKSettingsViewController.new;
    vc.kk_navTitle = @"设置";
    [self.navigationController pushViewController:vc animated:true];
}

- (void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navShadowImage        = UIImage.new;
    self.kk_navShadowColor        = [UIColor clearColor];
    self.kk_navBackgroundColor    = UIColor.clearColor;
    self.kk_navRightBarButtonItem = [UIBarButtonItem kk_itemWithTitle:nil
                                                           titleColor:nil
                                                            imageName:[UIImage imageNamed:@"profile_settings.png"]
                                                        highImageName:[UIImage imageNamed:@"profile_settings.png"]
                                                               target:self
                                                               action:@selector(kk_settingsEvent:)];
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
