//
//  KKTabBarController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTabBarController.h"

#import "KKHomeViewController.h"
#import "KKTidingViewController.h"
#import "KKFindViewController.h"
#import "KKProfileViewController.h"

@interface KKTabBarController ()<UITabBarControllerDelegate,CYLTabBarControllerDelegate>

@end

@implementation KKTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
