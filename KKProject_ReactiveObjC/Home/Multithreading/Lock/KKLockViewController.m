//
//  KKLockViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/13.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLockViewController.h"

@interface KKLockViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation KKLockViewController
/****************************************
 
 线程间资源共享&线程加锁
 多条线程存在同时操作（删、查、读、写）同一个文件or对象or变量
 
 NSLock:对象锁
 -(BOOL)tryLock;//尝试加锁，不会阻塞线程。true则加锁成功，false则失败，说
 明其他线程在加锁中这个方法无论如何都会立即返回。

 -(BOOL)lockBeforeDate:(NSDate *)limit;//尝试在指定NSDate之前加锁，会阻塞线程。true则加
 锁成功，false则失败，说明其他线程在加锁中这个方法无论如何都会立即返回。在拿不到锁时不会一直在那等待。
 该线程将被阻塞，直到获得了锁，或者指定时间过期。
 @property (nullable, copy) NSString *name;线程锁名称
 
 
 
 NSConditionLock:条件锁
 - (instancetype)initWithCondition:(NSInteger)condition;//初始化条件锁
 - (void)lockWhenCondition:(NSInteger)condition;//加锁 （条件是：锁空闲，即没被占用；条件成立）
 - (BOOL)tryLock; //尝试加锁，成功返回TRUE，失败返回FALSE
 -(BOOL)tryLockWhenCondition:(NSInteger)condition;//在指定条件成立的情况下尝试加锁，
 成功返回TRUE，失败返回FALSE
 - (void)unlockWithCondition:(NSInteger)condition;//在指定的条件成立时，解锁
 - (BOOL)lockBeforeDate:(NSDate *)limit;//在指定时间前加锁，成功返回TRUE，失败返回FALSE，
 - (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;//条件成立的情况下，在指定时间前加锁，成功返回TRUE，失败返回FALSE，
 @property (readonly) NSInteger condition;//条件锁的条件
 @property (nullable, copy) NSString *name;//条件锁的名称
 
 
 
 
 
 NSRecursiveLock:递归锁
 - (BOOL)tryLock;//尝试加锁，成功返回TRUE，失败返回FALSE
 - (BOOL)lockBeforeDate:(NSDate *)limit;//在指定时间前尝试加锁，成功返回TRUE，失败返回FALSE
 @property (nullable, copy) NSString *name;//线程锁名称
 
 
 
 
 pthread_mutex:互斥锁
 
 
 
 OSSpinLock:自旋锁
 
 
 
 
 dispatch_semaphore:信号量实现加锁
 
 
 
 @synchronized
 ****************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        _dataList = [NSMutableArray arrayWithObjects:@{@"title":@"NSLock",@"controller":@"KKNSLockViewController"},@{@"title":@"NSConditionLock",@"controller":@"KKNSConditionLockViewController"},@{@"title":@"NSRecursiveLock",@"controller":@"KKNSRecursiveLockViewController"},@{@"title":@"pthread_mutex",@"controller":@"KKPthread_mutexViewController"},@{@"title":@"OSSpinLock",@"controller":@"KKOSSpinLockViewController"},@{@"title":@"dispatch_semaphore",@"controller":@"KKdispatch_semaphoreViewController"},@{@"title":@"synchronized",@"controller":@"KKSynchronizedViewController"}, nil];
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
