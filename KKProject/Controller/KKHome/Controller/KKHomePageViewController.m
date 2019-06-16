//
//  KKHomePageViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/6.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomePageViewController.h"
#import "KKHomePageViewModel.h"

@interface KKHomePageViewController ()
@property (nonatomic,strong) KKHomePageViewModel *viewModel;

@end

@implementation KKHomePageViewController

- (UIView *)listView {
    return self.view;
}

//可选使用，列表显示的时候调用
- (void)listDidAppear {
    if (self.viewModel.pageDatas.count == 0) {
        [self.viewModel.refreshCommand execute:self.categoryModel];
    }
}

//可选使用，列表消失的时候调用
- (void)listDidDisappear {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navigationBar.hidden = true;
}





#pragma mark -
#pragma mark - initialize instance
-(KKHomePageViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = KKHomePageViewModel.alloc.init;
        _viewModel.categoryModel = self.categoryModel;
    }
    return _viewModel;
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
