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

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
    
@end

@implementation KKLanuchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.cyanColor;
    
    
}


- (void) kk_enterApp{
    
    AppDelegate *app = (AppDelegate *)UIApplication.sharedApplication.delegate;
    UIViewController *viewController = [KKErrorHelper kk_defaultVC];
    app.window.rootViewController = viewController;
    [UIView transitionWithView:app.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
    
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
