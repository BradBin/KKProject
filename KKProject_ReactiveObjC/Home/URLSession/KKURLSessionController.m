//
//  KKURLSessionController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKURLSessionController.h"
#import "KKURLSessionView.h"


/*******************
 NSURLSession的使用
 
 *******************/

@interface KKURLSessionController ()

@property (nonatomic, strong) KKURLSessionView *urlSessionView;


@end

@implementation KKURLSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.urlSessionView = ({
        KKURLSessionView *view = [[KKURLSessionView alloc] init];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
         UIEdgeInsets insets = [UIApplication.sharedApplication.windows firstObject].safeAreaInsets;
            make.top.equalTo(view.superview).offset(44 + insets.top);
            make.centerX.equalTo(view.superview);
            make.width.equalTo(view.superview);
            make.bottom.equalTo(view.superview);
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
