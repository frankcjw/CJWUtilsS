//
//  QPCacheUtilsPro.swift
//  CJWUtilsS
//
//  Created by Frank on 3/31/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import SwiftyJSON
import AwesomeCache

/// 只负责存储字符串类型
public class QPCacheUtilsPro: NSObject {

	/**
	 储存

	 - parameter object:  要储存的对象,comfess to nscoding的内容
	 - parameter key:     key
	 - parameter expires: 超时,默认不缓存

	 - returns: 是否储存成功
	 */
	public class func cache(object: AnyObject, key: String, expires: NSTimeInterval = 0) -> Bool {

		var json: JSON!

		if let value = object as? NSDictionary {
			json = JSON(value)
		} else if let value = object as? NSArray {
			json = JSON(value)
		} else if let value = object as? String {
			json = JSON(value)
		} else {
			log.warning("cache can only be NSDictionary , NSArray , String")
			return false
		}
		do {
			let cache = try Cache<NSString>(name: "QPHttpCacheName")
			let value = json.toJSONString()
			cache.setObject(value, forKey: key, expires: .Seconds(expires))
			return true
		} catch _ {
			log.warning("Something went wrong when cacheResponse :(")
			return false
		}
	}

	/**
	 获取缓存对象

	 - parameter forKey: key

	 - returns: 如果不存在在返回nil
	 */
	public class func object(forKey: String) -> AnyObject? {
		do {
			let cache = try Cache<NSString>(name: "QPHttpCacheName")
			if let cacheResult = cache.objectForKey(forKey) as? String {
				let json = JSON.parse(cacheResult)
				return json.rawValue
			}
		} catch _ {
			log.warning("Something went wrong when responseFromCache :(")
		}
		return nil
	}

	/**
	 清楚缓存

	 - returns: 是否完成
	 */
	public class func clearCache() -> Bool {
		do {
			let cache = try Cache<NSString>(name: "QPHttpCacheName")
			cache.removeAllObjects()
			return true
		} catch _ {
			log.warning("Something went wrong when clearHttpCache :(")
			return false
		}
	}
}
