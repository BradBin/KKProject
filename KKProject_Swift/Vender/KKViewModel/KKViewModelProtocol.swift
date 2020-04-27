//
//  KKViewModelProtocol.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/23.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import Foundation


/***
 AnyObject:代表任何class类型的实例.
 Any:代表任何类型,甚至包括方法(func)类型.
 总结:
 1.AnyObject是Any的子集
 2.用class关键字定义的对象就是AnyObject.
 3.所有不是用class关键字定义的对象就不是AnyObject，而是Any
 4.参数常使用Any
 **/

public protocol KKViewModelProtocol{
    
    //初始化
    func kk_initialzie() -> Void
}
