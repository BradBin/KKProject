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
    
    func categoryTitle(params : NSMutableDictionary) -> Observable<Any> {
        return homeProvider.rx.request(.categoryTitle(params: params)).filterSuccessfulStatusCodes().mapJSON().asObservable()
    }
}


/// RxSwift 首页的VM
class KKHomeRxSwiftViewModel: KKViewModel{
    
    
    
}

/// Reactive 首页的VM
class KKHomeReactiveCocoaViewModel: KKViewModel {
    
}
