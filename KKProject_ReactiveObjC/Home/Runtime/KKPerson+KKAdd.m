//
//  KKPerson+KKAdd.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/11.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKPerson+KKAdd.h"
#import <objc/message.h>
#import <objc/runtime.h>


/*****************************************
 OBJC_ASSOCIATION_ASSIGN 等价于 @property(assign)。
 OBJC_ASSOCIATION_RETAIN_NONATOMIC等价于 @property(strong, nonatomic)。
 OBJC_ASSOCIATION_COPY_NONATOMIC等价于@property(copy, nonatomic)。
 OBJC_ASSOCIATION_RETAIN等价于@property(strong,atomic)。
 OBJC_ASSOCIATION_COPY等价于@property(copy, atomic)。
 
 *****************************************/

@implementation KKPerson (KKAdd)

-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)name{
    return objc_getAssociatedObject(self, _cmd);
}


-(void)setAge:(NSInteger)age{
    objc_setAssociatedObject(self, @selector(age), @(age), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)age{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setIsStaff:(BOOL)isStaff{
    objc_setAssociatedObject(self, @selector(isStaff), @(isStaff), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isStaff{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setPersonInfo:(KKPersonInfoBlock)personInfo{
    objc_setAssociatedObject(self, @selector(personInfo), personInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(KKPersonInfoBlock)personInfo{
    return objc_getAssociatedObject(self, _cmd);
}


@end
