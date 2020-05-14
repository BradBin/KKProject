//
//  KKRuntimeController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/10.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKRuntimeController.h"
#import "KKPerson.h"
#import "KKPerson+KKAdd.h"

@interface KKRuntimeController ()

@end

@implementation KKRuntimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //测试：Peson调用并未实现的类方法、实例方法，并没有崩溃
    KKPerson *p = KKPerson.alloc.init;
    p.name = @"bin";
    p.age  = 18;
    p.isStaff = true;
    NSLog(@"人员基本信息:  %@ %ld %d",p.name,(long)p.age,p.isStaff);
    
    
    ///调用block
    p.personInfo = ^(KKPerson * _Nonnull person) {
        NSLog(@"人员基本信息block:  %@ %ld %d",person.name,(long)person.age,person.isStaff);
    };
    ///执行block
    p.personInfo(p);
    
    
    [p singSong:@"漫步人生路"];
    [KKPerson haveMeal:@"牛排"];
    
    
    
    KKEngineer *engineer = KKEngineer.alloc.init;
    [engineer haveSkill:@"iOS"];
    
    [KKEngineer haveSkill:@"iOS"];
    
    
    KKFarmer *farmer = KKFarmer.alloc.init;
    
    [farmer haveFruit:@"Apple"];
    //    [farmer eatFruit:@"watermelon"];
    
    [KKFarmer haveFruit:@"Orange"];
    
    
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
