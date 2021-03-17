//
//  KKHomeViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/8.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeViewController.h"

@interface KKHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation KKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#warning mark -应用之间跳转
    /*****
     1.应用之间的跳转
     2.应用之间跳转到对应的页面
     ****/
    self.rightButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44, 44);
        [button setTitle:@"切应用" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        button;
    });
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //获取应用程序URL Scheme
        NSURL *appURL = [NSURL URLWithString:@"RxSwift://?"];
        //判断是否安装对应的应用程序
        if ([UIApplication.sharedApplication canOpenURL:appURL]) {
            [UIApplication.sharedApplication openURL:appURL options:@{} completionHandler:^(BOOL success) {
                NSLog(@"安装了程序 : %@",success? @"调用成功":@"调用失败");
            }];
        }else{
            NSLog(@"没有安装程序");
        }
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    self.tableView = ({
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        view.delegate = self;
        view.dataSource = self;
        view.sectionHeaderHeight = 10.0;
        view.sectionFooterHeight = 10.0;
        [view registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell.Identifier"];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view.superview);
        }];
        view;
    });
    
    
    // Do any additional setup after loading the view.
}


#pragma mark -UITableViewDelegate/UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell.Identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell.Identifier"];
    }
    
    cell.textLabel.text = [self.dataList[indexPath.section] objectForKey:@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    NSDictionary *dict = self.dataList[indexPath.section];
    NSString *className = [dict objectForKey:@"controller"];
    if (className.length) {
        UIViewController *vc = [[[NSClassFromString(className) class] alloc] init];
        vc.title = [dict objectForKey:@"title"];
        [self.navigationController pushViewController:vc animated:true];
    }
}

#pragma mark -Lazy Instance

-(NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [NSMutableArray arrayWithObjects:@{@"title":@"scrollView",@"controller":@"KKScrollViewController"},
                     @{@"title":@"定时器",@"controller":@"KKTimerViewController"},
                     @{@"title":@"ReativeObjC",@"controller":@"KKReactiveObjCController"},@{@"title":@"NSFileHandle/NSFileManager",@"controller":@"KKFileHandleViewController"},@{@"title":@"NSURLSession",@"controller":@"KKURLSessionController"},@{@"title":@"事件响应/传递",@"controller":@"KKEventResponseController"},@{@"title":@"Lock",@"controller":@"KKLockViewController"},@{@"title":@"Thread",@"controller":@"KKThreadViewController"},@{@"title":@"GCD",@"controller":@"KKGCDViewController"},@{@"title":@"NSOPerationQueue",@"controller":@"KKOPerationQueueViewController"},@{@"title":@"RunLoop",@"controller":@"KKRunLoopController"},@{@"title":@"运行时RunTime",@"controller":@"KKRuntimeController"}, nil];
    }
    return _dataList;
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
