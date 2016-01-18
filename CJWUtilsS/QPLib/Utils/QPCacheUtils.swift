//
//  QPCacheUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit
import CryptoSwift

class QPCacheUtils: NSObject {
    class var sharedInstance : QPCacheUtils {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : QPCacheUtils? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = QPCacheUtils()
        }
        return Static.instance!
    }
    
    var container =  NSMutableDictionary()
    
    class func cache(value:AnyObject , forKey : String){
        QPCacheUtils.cache(value, forKey: forKey, toDisk: false)
    }
    
    class func cache(value:AnyObject , forKey : String,toDisk:Bool){
        let newKey = forKey.md5()
//        let newKey = (forKey as NSString).encryptToAESString()
        print("cache \(forKey) \(newKey) \(value)")
        QPCacheUtils.sharedInstance.container.setObject(value, forKey: newKey)
        if toDisk {
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject(value, forKey: newKey)
        }
        
    }
    
    class func getCacheBy(key:String) -> AnyObject?{

        let newKey = key.md5()//
        print("getCacheBy \(key) \(newKey)")
        let obj = QPCacheUtils.sharedInstance.container[newKey]
        if obj == nil {
            let userDefault = NSUserDefaults.standardUserDefaults()
            let value = userDefault.objectForKey(newKey)
            return value
        }else{
            return obj
        }
    }
    
    class func isExist(key:String) -> Bool{
//        let newKey = (key as NSString).encryptToAESString()
        let newKey = key.md5()//
        print("isExist \(key) \(newKey)")
        if let _ = QPCacheUtils.sharedInstance.container[newKey] {
            return true
        }else{
            let userDefault = NSUserDefaults.standardUserDefaults()
            if let _ = userDefault.objectForKey(newKey) {
                return true
            }
            return false
        }
    }
}


extension NSObject {
    private func appendingKey() -> String{
        return "\(HOST)-\(QPMemberUtils.sharedInstance.memberId)"
    }
    
    func cacheBy(key : String) -> AnyObject?{
        let newKey = key + appendingKey()
        return QPCacheUtils.getCacheBy(newKey)
    }
    
    func cache(cacheObject: AnyObject!, forKey: String!){
        let newKey = forKey + appendingKey()
        QPCacheUtils.cache(cacheObject, forKey: newKey)
    }
    
    func cacheToDisk(cacheObject: AnyObject!, forKey: String!){
        let newKey = forKey + appendingKey()
        QPCacheUtils.cache(cacheObject, forKey: newKey, toDisk: true)
    }
    
    func cacheIsExist(key:String) -> Bool {
        let newKey = key + appendingKey()
        return QPCacheUtils.isExist(newKey)
    }
}

