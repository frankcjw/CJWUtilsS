//
//  QPKeyChainUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

class QPKeyChainUtils: NSObject {
    class var sharedInstance : QPKeyChainUtils {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : QPKeyChainUtils? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = QPKeyChainUtils()
        }
        return Static.instance!
    }
    
    override init() {
    }
    
    class func setString(value:String, forKey key:String){
        let userDefault = NSUserDefaults.standardUserDefaults()
        let secretKey = (key as NSString).encryptToAESString()
        let secretValue = (value as NSString).encryptToAESString()
        userDefault.setObject(secretValue, forKey: secretKey)
    }
    
    class func stringForKey(key:String) -> String?{
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let secretKey = (key as NSString).encryptToAESString()
        if let secretValue = userDefault.objectForKey(secretKey) as? String {
            let value = (secretValue as NSString).decryptAESString()
            return value
        }else{
            return nil
        }
    }
    
    class func removeKey(key:String){
        let secretKey = (key as NSString).encryptToAESString()
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.removeObjectForKey(secretKey)
    }
    
    class func removeAllItems(){
    }
}

