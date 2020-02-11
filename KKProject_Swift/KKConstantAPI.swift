//
//  KKConstantAPI.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/22.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import Foundation
import Moya


let KKBaseURL        = "https://is.snssdk.com/"
let categoryTitleAPI = "article/category/get_subscribed/v1/?"
let categoryListAPI  = "article/category/get_subscribed/v1/?"

let accountIID = "17769976909"
let deviceID   = "41312231473"

let headerFields: [String: String] = ["system": "iOS","sys_ver": String(UIDevice.version())]
let publicParameters: [String: String] = ["language": "_zh_CN"]

enum API {
    case categoryTitle(params : NSMutableDictionary)
    case categoryTitleList(params : NSMutableDictionary)
}

extension API: TargetType {
    var baseURL: URL {
        return URL.init(string: KKBaseURL)!
    }
    
    var path: String {
        switch self {
        case .categoryTitle(params: _):
            return categoryTitleAPI
        default:
            return ""
        }
    }
    
    var method: Moya.Method  {
        switch self {
        case .categoryTitle(params: _):
            return .get
        default:
            return .get
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .categoryTitle(params: _):
            return ["device_id":deviceID , "iid":accountIID, "aid":13]
        default:
            return [:]
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var parameterEncoding: ParameterEncoding {
         return URLEncoding.default
     }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        return [:]
    }
}

//private let endPointClosure = {( target : API) ->Endpoint in
//    let defaultEndPoint = MoyaProvider<API>.defaultEndpointMapping(for: target)
//    return defaultEndPoint.adding(newHTTPHeaderFields: headerFields)
//}


/// 首页的请求对象Provider
let homeProvider = MoyaProvider<API>.init()

