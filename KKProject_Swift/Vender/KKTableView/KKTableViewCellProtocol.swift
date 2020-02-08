//
//  KKTableViewCellProtocol.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/2/1.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import Foundation

public protocol KKTableViewCellProtocol{
    
    func kk_setupView() -> Void
    func kk_bindViewModel() -> Void
}
