//
//  QPMemberUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

private let KEY_LOGIN = "LOGIN"
private let KEY_ACCOUNT = "ACCOUNT"
private let KEY_PASSWORD = "PASSWORD"
private let KEY_YES = "YES"
private let KEY_NO = "NO"

class QPMemberUtils: NSObject {
    
    var memberInfo = NSDictionary() {
        didSet {
            if let imToken = memberInfo["imToken"] as? String {
                self.imToken = imToken
            }
        }
    }
    
    var loginFlag = false
    
    class func login(){
        QPMemberUtils.sharedInstance.loginFlag = true
    }
    
    var imToken = ""
    class func logout(){
//        QPHttpUtils.sharedInstance.logout({ (resp) -> Void in
//            //
//            }) { () -> Void in
//                //
//        }
    }
    
    //    class func isLogin() -> Bool{
    //        if let str = QPKeyChainUtils.stringForKey(KEY_LOGIN) {
    //            if str == KEY_YES {
    //                return true
    //            }
    //        }
    //        return false
    //    }
    
    class func clearUserInfo(){
        QPKeyChainUtils.removeKey(KEY_PASSWORD)
        QPKeyChainUtils.removeKey(KEY_ACCOUNT)
    }
    
    class func isLoginInfoExist(){
        if QPKeyChainUtils.stringForKey(KEY_ACCOUNT) != nil && QPKeyChainUtils.stringForKey(KEY_PASSWORD) != nil {
        }
    }
    
    class func saveInfo(account:String,password:String){
        QPKeyChainUtils.setString(account, forKey: KEY_ACCOUNT)
        QPKeyChainUtils.setString(password, forKey: KEY_PASSWORD)
        QPMemberUtils.login()
    }
    
    class func account() -> String? {
        return QPKeyChainUtils.stringForKey(KEY_ACCOUNT)
    }
    
    class func password() -> String? {
        return QPKeyChainUtils.stringForKey(KEY_PASSWORD)
    }
    
    class var sharedInstance : QPMemberUtils {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : QPMemberUtils? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = QPMemberUtils()
        }
        return Static.instance!
    }
    
    var memberId : Int {
        if let id = memberInfo["id"] as? Int {
            return id
        }
        return -1
    }
    
    var name : String {
        if let value = memberInfo["name"] as? String {
            return value
        }
        return ""
    }
    
    var thumbnail : String {
        let tmp = logo.stringByReplacingOccurrencesOfString(".png", withString: "_s.png")
        return tmp
    }
    
    var logo : String {
        if let value = memberInfo["logo"] as? String {
            return value
        }
        return ""
    }
}
