//
//  KKModel.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/2/11.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import HandyJSON

class KKModel<T: HandyJSON>: HandyJSON {
    var code    : Int = -1
    var message : String?
    var data    : T?
    required init(){}
}
