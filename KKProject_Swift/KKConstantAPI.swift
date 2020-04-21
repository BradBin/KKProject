//
//  KKConstantAPI.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/1/22.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import Foundation
import Moya


enum API {
    case recommand(sex:Int)
    case searchResult(dict:[String : Any])
}

extension API : TargetType{
    
    ///服务器地址
    var baseURL: URL {
        #if KK_SWIFT
        
        switch self {
        case .recommand:
            fallthrough
        default:
            return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!
        }
        
        #elseif KK_SWIFT_RELEASE
        
        switch self {
        case .recommand:
            fallthrough
        default:
            return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!
        }
        
        #endif
    }
    
    ///服务请求具体路径
    var path: String {
        switch self {
        case .recommand:
            return "comic/boutiqueListNew"
        case .searchResult:
            return "search/searchResult"
        }
    }
    
    ///请求类型
    var method: Moya.Method {
        switch self {
        case .recommand:
            return .get
        default:
            return .post
        }
    }
    
    /// 单元测试模拟数据,在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    ///请求任务事件
    var task: Task {
        switch self {
        case .recommand(let sex):
            return .requestParameters(parameters: ["sexType":sex], encoding: URLEncoding.default)
        case .searchResult(let dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        }
    }
    
    ///是否执行Alamofire验证
    var validate: Bool {
        return false
    }
    
    /// 请求头
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}



/// 首页的请求对象Provider
let homeProvider = MoyaProvider<API>.init(requestClosure:timeoutClosure ,plugins: [NetPlugin()])


/// 设置请求超时时长
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<API>.RequestResultClosure) -> Void in
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

class NetPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        print("NetPlugin prepare")
        return request
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("NetPlugin willSend")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("NetPlugin didReceive")
    }
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        print("NetPlugin process")
        return result
    }
}
