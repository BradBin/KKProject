//
//  KKHomeViewModel.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/25.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit
import Moya

import RxSwift
import RxCocoa

import ReactiveCocoa



/// 枚举 存储网络请求
enum KKHomeApi {
    case categoryTitle( params : NSMutableDictionary)
}

extension KKHomeApi : TargetType{
    
    var baseURL: URL {
        return URL.init(string: "www.baidu.com")!
    }
    
    var path: String {
        switch self {
            
        case .categoryTitle(params : _):
            return "categoryTitle/"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categoryTitle(params : _):
            return .post
        default:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["token" : "21nn3eewmnqnemnmeqm"]
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        return Data.init()
    }
}



/// RxSwift
class KKHomeViewModel: KKViewModel{
    

    let provider : MoyaProvider  = MoyaProvider<KKHomeApi>()
    


    
}



class KKHomeReactiveCocoaViewModel: KKViewModel {
    
}


