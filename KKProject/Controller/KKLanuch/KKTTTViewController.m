//
//  KKTTTViewController.m
//  KKProject
//
//  Created by youbin on 2020/3/1.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTTTViewController.h"


@interface KKTTTViewController ()

@end

@implementation KKTTTViewController

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
    
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
   
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
