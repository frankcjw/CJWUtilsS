//
//  QPHttpUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let HOST = ""

let BASE_URL = HOST + "service/"

private let URL_LOGIN = BASE_URL + "login"
private let URL_LOGOUT = BASE_URL + "logout/"

let maxPageSize = NSNumber(int: Int32.max).integerValue
let pageSize = 50

class QPHttpUtils: NSObject {
    
    var sessionKey = ""
    
//    var httpManager = AFHTTPRequestOperationManager()
    
    class var sharedInstance : QPHttpUtils {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : QPHttpUtils? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = QPHttpUtils()
        }
        return Static.instance!
    }
    
    typealias CJWSuccessBlock = (response:JSON) -> ()
    typealias CJWFailBlock = () -> ()
    
    func newHttpRequet(url: String, param: [String : AnyObject]!, success: CJWSuccessBlock!, fail: CJWFailBlock!){
        
        Alamofire.request(.GET, url, parameters: param)
            .responseJSON { response in
//                print(response.response?.statusCode) // URL response
//                //                print(response.data)     // server data
//                print(response.result)   // result of response serialization
////                print(response.result.value)
                
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//                debugPrint(response)
                print(response.result)
                if response.result.isSuccess {
                    if let value = response.result.value {
                        if let info = value as? NSDictionary {
                            if let content = info["content"] as? String {
                                print("content1 \(content)")
                            }
                        }
                        let json = JSON(value)
                        let content = json["content"].stringValue
                        print("content2 \(content)")
                        success(response: json)

//                        if let str = json.string {
//                            if str.hasPrefix("error") {
////                                print("handle error ")
////                                success(response: value)
//                            }else{
//                                success(response: value)
//                            }
//                        }
                    }
                }
        }.responseString { (response) -> Void in
            let result = response.result
            if result.isSuccess {
                if let value = response.result.value {
                    let json = JSON(value)
                    if let str = json.string {
                        if str.hasPrefix("error") {
                            print("handle error ")
                            success(response: json)
                        }else{
//                            success(response: value)
                        }
                    }
                }
            }else if result.isFailure {
                debugPrint(response)
                fail()
            }
        }
    }
    
//    private func newHttpRequet(url: String, param: [NSObject : AnyObject]!, success: CJWSuccessBlock!, fail: CJWFailBlock!){
////        CJWNetworkActivityIndicator.startIndicator()
//        print("url \(url) param \(param)")
//        httpManager.POST(url, parameters: param, success: { (operation, responseObject) -> Void in
//            CJWNetworkActivityIndicator.stopIndicator   ()
//            success(responseObject)
//            }) { (operation, error) -> Void in
//                CJWNetworkActivityIndicator.stopIndicator()
//                if let statusCode = operation!.response?.statusCode {
//                    if statusCode == 200 {
//                        success(operation!.responseString)
//                        return
//                    }
//                }
//                print("url:\(url)\n\(error) \(operation!.responseString)")
//                fail()
//        }
//        
//    }
//    func requestUrlWithCache(url: String!, param: [NSObject : AnyObject]!, success: CJWSuccessBlock!, failure: CJWFailBlock!){
//        let key = "\(url)-\(param)"
//        var compare : AnyObject = ""
//        if let result = QPCacheUtils.getCacheBy(key) {
//            compare = result
//            success(result)
//        }else{
//            print("object from cache fail \(key)")
//        }
//        requestUrl(url, param: param, success: { (resp) -> Void in
//            if compare.isEqual(resp){
//            }else{
//                success(resp)
//                QPCacheUtils.cache(resp, forKey: key, toDisk: true)
//            }
//            
//            }) { () -> Void in
//                failure()
//        }
//    }
//    
//    func requestUrl(url: String!, param: [NSObject : AnyObject]!, success: CJWSuccessBlock!, fail: CJWFailBlock!) {
//        var newParam = addAuth(param)
//        if url == URL_LOGIN {
//            newParam = param
//        }
//        //        self.newHttpRequet(url, param: newParam, success: success, fail: fail)
//        self.newHttpRequet(url, param: newParam, success: { (resp) -> Void in
//            if let result = resp as? NSDictionary {
//                if let error = result["error"] as? String {
//                    print("error \(error)")
//                    if error == "logout" {
//                        //                        AppDelegate.toHome()
//                        NSNotificationCenter.defaultCenter().postNotificationName("GoLogin", object: nil)
//                        UIApplication.sharedApplication().keyWindow?.rootViewController?.view.showTemporary("您的账号已在别处登录")
//                        fail()
//                        return
//                    }else if error == "nologin" {
////                        self.http.login({ () -> () in
////                            self.newHttpRequet(url, param: self.addAuth(param), success: { (reps) -> Void in
////                                success(resp)
////                                }, fail: { () -> Void in
////                                    fail()
////                            })
////                            }, loginFailBlock: { (text) -> () in
////                                fail()
////                            }, failure: { () -> Void in
////                                fail()
////                        })
//                        return
//                    }
//                }
//            }
//            success(resp)
//            }) { () -> Void in
//                fail()
//        }
//        
//    }
//    
//    private func pushId() -> String{
//        return QPPushUtils.getPushID()
//    }
//    
//    func addAuth(param: [NSObject : AnyObject]!) -> [NSObject : AnyObject]!{
//        if param == nil {
//            return param
//        }else{
//            let newParam = NSMutableDictionary(dictionary: param as NSDictionary)
//            if QPMemberUtils.sharedInstance.memberId != -1 {
//                let uid = QPMemberUtils.sharedInstance.memberId
//                let session = QPHttpUtils.sharedInstance.sessionKey
//                let str = "\(uid)-\(pushId())"
//                let auth = CJWDesEncrypt.encrypt(str, key: session)
//                print("\(str) \(auth) \(session)")
//                newParam.setValue(auth, forKey: "auth")
//                return newParam as [NSObject : AnyObject]
//            }
//            return newParam as [NSObject : AnyObject]
//        }
//    }
}

extension NSObject {
    var http : QPHttpUtils {
        return QPHttpUtils.sharedInstance
    }
}
