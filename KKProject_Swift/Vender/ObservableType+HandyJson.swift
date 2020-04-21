//
//  Observable+HandyJson.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/3/26.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import Foundation
import Moya
import RxSwift
import HandyJSON


private enum mapErrpr : Swift.Error{
    case errorInfo(String)
}

extension mapErrpr : LocalizedError{
    var errorDescription: String?{
        switch self {
        case .errorInfo(let text): return NSLocalizedString(text, comment: "error")
        }
    }
}

//fileprivate private
enum ResponseError : Swift.Error {
    // 解析失败
    case ParseJSONError
    // 网络请求发生错误
    case RequestFailed
    // 接收到的返回没有data
    case NoResponse
    //服务器返回了一个错误代码
    case UnexpectedResult(resultCode: Int?, resultMsg: String?)
}

enum RequestStatus: Int {
    case requestSuccess = 1
    case requestError
}

fileprivate let RESULT_CODE = "code"
fileprivate let RESULT_MSG  = "message"
fileprivate let RESULT_DATA = "data"

public extension ObservableType{
    func mapResponseToObject<T: HandyJSON>(type: T.Type) -> Observable<T> {
        
        return map { response in
            
            // 得到response
            guard let response = response as? Moya.Response else {
                throw ResponseError.NoResponse
            }
            
            #if DEBUG
            if let request = response.request {
                print("Request:\(request)")
                if let httpMethod = request.httpMethod{
                    print("httpMethod:\(httpMethod) ")
                }
            }
            
            let JSONString = String(data: response.data, encoding: .utf8)
            
            if let jsonString = JSONString{
                print("Response:\(jsonString)")
            }
            #endif
            
            // 检查状态码
            guard ((200...209) ~= response.statusCode) else {
                throw ResponseError.RequestFailed
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any]  else {
                throw ResponseError.NoResponse
            }
            
            // 服务器返回code
            if let code = json[RESULT_CODE] as? Int {
                if code == RequestStatus.requestSuccess.rawValue {
                    
                    let object = JSONDeserializer<T>.deserializeFrom(dict: json)
                    return object!
                    
                } else {
                    throw ResponseError.UnexpectedResult(resultCode: json[RESULT_CODE] as? Int , resultMsg: json[RESULT_MSG] as? String)
                }
            } else {
                throw ResponseError.ParseJSONError
            }
            
        }
    }
    
    func mapResponseToObjectArray<T: HandyJSON>(type: T.Type) -> Observable<[T]> {
        return map { response in
            
            // 得到response
            guard let response = response as? Moya.Response else {
                throw ResponseError.NoResponse
            }
            
            #if DEBUG
            if let request = response.request {
                print("Request:\(request)" )
                if let request = response.request {
                    print("Request:\(request)")
                    if let httpMethod = request.httpMethod{
                        print("httpMethod:\(httpMethod)")
                    }
                }
            }
            
            
            let JSONString = String(data: response.data, encoding: .utf8)
            if let jsonString = JSONString{
                print("Response:\(jsonString)")
            }
            #endif
            
            // 检查状态码
            guard ((200...209) ~= response.statusCode) else {
                throw ResponseError.RequestFailed
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any]  else {
                throw ResponseError.NoResponse
            }
            
            // 服务器返回code
            if let code = json[RESULT_CODE] as? Int {
                if code == RequestStatus.requestSuccess.rawValue {
                    guard let objectsArrays = json[RESULT_DATA] as? NSArray else {
                        throw ResponseError.ParseJSONError
                    }
                    // 使用HandyJSON解析成对象数组
                    if let objArray = JSONDeserializer<T>.deserializeModelArrayFrom(array: objectsArrays) {
                        if let objectArray: [T] = objArray as? [T] {
                            return objectArray
                        }else {
                            throw ResponseError.ParseJSONError
                        }
                    }else {
                        throw ResponseError.ParseJSONError
                    }
                    
                } else {
                    throw ResponseError.UnexpectedResult(resultCode: json[RESULT_CODE] as? Int , resultMsg: json[RESULT_MSG] as? String)
                    
                }
            } else {
                throw ResponseError.ParseJSONError
            }
        }
    }
}


extension Array: HandyJSON{ }
