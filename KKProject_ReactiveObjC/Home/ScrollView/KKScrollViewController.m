//
//  KKScrollViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/7/6.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKScrollViewController.h"
#import "KKScrollView.h"

@interface KKScrollViewController ()

@property (nonatomic, strong) KKScrollView *scrollView;

@end

@implementation KKScrollViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView = ({
        KKScrollView *view = KKScrollView.alloc.init;
        view.backgroundColor = UIColor.lightGrayColor;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view.superview);
        }];
        view;
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
