//
//  KKPerson.swift
//  KKProject_RxSwift
//
//  Created by youbin on 2020/4/27.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit

/**********************************
 在观察某个属性是否变化的时候,采用KVO的方式更为简单直接
 
 swift中使用KVO需要满足以下条件:
 1.被观察的属性前需要添加 @objc dynamic
 2.被观察的类必须继承NSObject
 
 否则报错:doesn't have a property named `name`.
 
 
 RxSwift提供了 rx.observe 和 rx.observeWeakly 两种方式的观察序列
 
 1. rx.observe 是对 KVO 的简单封装，执行效率更高。它要求被观察的属性路径都是使用 strong 修饰的，如果观察使用 weak 修饰的属性，可会发生崩溃;注意循环引用
 
 
 2. rx.observeWeakly 可以处理属性变为空的情况，所有可以用在使用 weak 修饰的属性
 
 备注: 使用 rx.observe 的地方，都是使用 rx.observeWeakly。但
 是，rx.observeWeakly 的性能没有 rx.observe 的高
 
 ***********************************/

class KKPerson : NSObject{
    
    @objc dynamic public var name : String?
    @objc dynamic var age: Int = 0
    
    init(name : String?, age : Int) {
        self.name = name
        self.age  = age
    }
}
