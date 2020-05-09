//
//  KKHomeViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/8.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeViewController.h"
#import "KKEventView.h"

@interface KKHomeViewController ()

@property (nonatomic, strong) KKEventView *eventView;

@end

@implementation KKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventView = ({
           KKEventView *view = KKEventView.new;
           view.backgroundColor = UIColor.magentaColor;
           [self.view addSubview:view];
           [view mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerX.equalTo(view.superview);
               make.centerY.equalTo(view.superview);
               make.width.equalTo(view.superview).multipliedBy(0.5);
               make.height.equalTo(view.superview).multipliedBy(0.5);
           }];
           view;
       });
       
       
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
