//
//  KKPerson+KKAdd.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/11.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKPerson.h"

NS_ASSUME_NONNULL_BEGIN

/****************************
runtime运行时:分类中添加属性

*****************************/


@class KKPerson;

typedef void(^KKPersonInfoBlock)(KKPerson *person);

@interface KKPerson (KKAdd)

@property (nonatomic,  copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,assign) BOOL      isStaff;
@property (nonatomic,  copy) KKPersonInfoBlock personInfo;


@end

NS_ASSUME_NONNULL_END
