//
//  HttpRequest.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


typealias SuccessBlock = ([String:Any]) -> Void
typealias FailureBlock = (AnyObject) -> Void
typealias ProgressBlock = (Float) -> Void

enum MethodType {
    case GET
    case POST
}

class HttpRequest: NSObject {
    
    static let shared:HttpRequest = {
        let share = HttpRequest()
        return share
    }()
    
    class func request(methodType:MethodType, urlString:String,param:[String:Any]? = nil,success:@escaping SuccessBlock) {
        
        let headers: HTTPHeaders = [
           //......
            "Content-Type":"application/json; charset=utf-8",
            "Accept": "application/json",
            "siteId":"100000"
        ]
        let allPath = API.BASE_URL + urlString
        
        if methodType == .POST {
            AF.request(allPath, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (dataResponse) in
                
//                print("request---\(dataResponse.request!)")
//                print("response---\(String(describing: dataResponse.response))")
//                print("data---\(String(describing: dataResponse.data))")
//                print("resultValue---\(dataResponse.result)")

                switch dataResponse.result {
                
                case let .success(result):
                    do {
                        let resultDict : [String:Any] = result as! [String:Any]
                        
                        let resp_code: Int = (resultDict["code"] as! Int)
//                        let code = resultDict["code"];
//                        let data = resultDict["data"];
                        
                        if resp_code == 0 {
                            // 成功
                         success(resultDict)
                        }else if resp_code == 1
                        {
                            // 失败
                        }
                        
                    }
                case let .failure(error):
                    let statusCode = dataResponse.response?.statusCode
                    print(error)
                }
                
            }
        }else
        {
            AF.request(allPath, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (dataResponse) in
                
            }
        }
    }
}


//protocol NetworkToolProtocol {
//
//    //POST 请求
//    static func makePostRequest(urlPath : String,parameters : [String:Any],successHandler: @escaping(_ json:JSON) ->(),errorMsgHandler : @escaping(_ errorMsg : String) ->(),networkFailHandler:@escaping(_ error : Error) -> ())
//}
//
//extension NetworkToolProtocol {
//    static func makePostRequest(urlPath : String,parameters : [String:Any],successHandler: @escaping(_ json:JSON) ->(),errorMsgHandler : @escaping(_ errorMsg : String) ->(),networkFailHandler:@escaping(_ error : Error) -> ())
//    {
//        let allPath = API.BASE_URL + urlPath
//
//
////        headers.add(name: "siteId", value: "100000")
//
//        let headers: HTTPHeaders = [
//           //......
//            "Content-Type":"application/json; charset=utf-8",
//            "Accept": "application/json",
//            "siteId":"100000"
//        ]
//
//        AF.request(allPath, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (dataResponse) in
//
//
//            dataResponse.value
////            print(dataResponse)
//            print("request---\(dataResponse.request!)")
//            print("response---\(String(describing: dataResponse.response))")
//            print("data---\(String(describing: dataResponse.data))")
//            print("resultValue---\(dataResponse.result)")
//            // 保存 cookies
//            let headerFields = dataResponse.response?.allHeaderFields as! [String : String]
//            let userCookie =  headerFields["Set-Cookie"]
//            UserDefaults.standard.set(userCookie, forKey: "userCookies")
//            UserDefaults.standard.synchronize()
//
//
//
//        }
//
//
//        // JSONEncoding 与 URLEncoding 服务接受数据的区别
////        AF.request(<#T##convertible: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>, requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
////        AF.request(allPath, method: .post, parameters: parameters, encoder: JSONEncoding.default, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>, requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
////        Alamofire.request(URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
////
////            print(response.response?.allHeaderFields as Any)
////            print(response);
////            // 网络连接或者服务错误的提示信息
////            guard response.result.isSuccess else
////            {
////                networkFailHandler(response.error!);
////                return
////            }
////
////            if let value = response.result.value {
////                let json = JSON(value)
////                //  print(json)
////                // 请求成功 但是服务返回的报错信息
////                guard json["errorCode"].intValue == 0 else {
////
////                    if(json["errorCode"].intValue == 50000){ // Token 过期重新登录
////
////                        errorMsgHandler(json["errorMsg"].stringValue)
////
////                        SVProgressHUD.showInfo(withStatus: "授权失效,请重新登录!")
////
////                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
////                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: RELOGIN_NOTIFY), object: nil)
////                        }
////                        return
////                    }
////
////                    errorMsgHandler(json["errorMsg"].stringValue)
////                    return
////                }
////                if json["result"].dictionary != nil{
////
////                    successHandler(json["result"])
////                    return
////                }else{
////
////                    successHandler(json)
////                    return
////                }
////            }
////        }
//
//    }
//}
//
//struct NetworkTool: NetworkToolProtocol {
//
//}
