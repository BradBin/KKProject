//
//  KKConstant.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/22.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import Foundation


let KKScreenSize   = UIScreen.main.bounds.size;
let KKScreenWidth  = UIScreen.main.bounds.size.width
let KKScreenHeight = UIScreen.main.bounds.size.height



/// 设备是否是刘海屏 true:刘海屏 otherwise false
@inline(__always) func KKIsPhoneSeries() -> Bool{
    var safeAreaInsets = UIEdgeInsets.zero
    if #available(iOS 11.0, *) {
        safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
    }
    return safeAreaInsets.bottom > 0 ? true : false
}




