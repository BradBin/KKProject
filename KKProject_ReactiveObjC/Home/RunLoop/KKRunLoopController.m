//
//  KKRunLoopController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/10.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKRunLoopController.h"
#import "KKRunLoopView.h"

@interface KKRunLoopController ()

@property (nonatomic, strong) KKRunLoopView *runLoopView;

@end

@implementation KKRunLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.runLoopView = ({
        KKRunLoopView *view = KKRunLoopView.new;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view.superview);
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
