//
//  KKHomeViewModel.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/25.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit

import RxSwift
import ReactiveCocoa


class KKHomeViewModel: KKViewModel{
    
    override func kk_initialzie() {
        
    }
    
    func recommand(sex : Int) -> Observable<KKResponseData<KKHomeModel>> {
        return homeProvider.rx.request(.recommand(sex: sex)).asObservable().mapResponseToObject(type: KKResponseData.self)
    }
}

