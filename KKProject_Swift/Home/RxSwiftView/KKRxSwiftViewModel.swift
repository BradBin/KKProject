//
//  KKRxSwiftViewModel.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/2/1.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit

import RxSwift

class KKRxSwiftViewModel : KKViewModel {
    override func kk_init() {
        print("kk_init")
    }
    
    /// 输出信号
    let usernameValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let everythingValid: Observable<Bool>
    
    /// 输入 -> 输出
    init(
        username: Observable<String>,
        password: Observable<String>
    ) {
        usernameValid = username.map{ $0.trimmingCharacters(in: .whitespacesAndNewlines).count >= 5}.share(replay: 1)
        passwordValid = password
            .map{$0.trimmingCharacters(in: .whitespacesAndNewlines).count >= 5}.share(replay: 1)
        
        everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
    }
    
}
