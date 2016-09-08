//
//  QPSecurityUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 9/7/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public class QPSecurityUtils: NSObject {

	public class func generateNewParam(param: [String: AnyObject]!, pushId: String) -> [String: AnyObject]! {

		var newParam = param
		if param == nil {
			newParam = [:]
			log.warning("generateNewParam param nil")
		}
		if let session = getCache("session") as? String {
			// let tmp = NSMutableDictionary(dictionary: param as NSDictionary)
			// let pushId = QPCacheUtils.getPushID()
			if let uid = getCache("UID") as? String {
				if uid == "0" {
					log.warning("uid = 0")
				} else {
					let str = "\(uid)-\(pushId)"
					let auth = CJWDesEncrypt.encrypt(str, key: session as String)
					// tmp.setObject(auth, forKey: "auth")
					newParam["auth"] = auth
					log.info("auth \(auth)")
					// newParam = tmp as [String : AnyObject]
					log.verbose("\(str)\n\(auth)\n\(newParam)")
				}
			} else {
				log.warning("fail to found UID")
			}
		} else {
			log.warning("no session was found")
		}
		return newParam
	}

	class func generateLoginParam(userName: String, password: String, pushId: String = "") -> NSDictionary {

		if pushId == "" {
			log.error("pushId error")
			// BuglyLog.level(BuglyLogLevel.Error, logs: "pushId error")
		} else {
		}
		// let session = VIPHttpUtils.sharedInstance.getSessionKey()
		let pwd = password.encryptPassword()
		let param = ["mobile": userName, "password": pwd, "pushId": pushId, "version": "\(AppInfoManager.getVersion())"]
		// BuglyLog.level(BuglyLogLevel.Info, logs: "\(userName) login version \(AppInfoManager.getVersion())")
		// log.debug("\(param)")
		log.info("\(userName) login version \(AppInfoManager.getVersion())")
		return param
	}

	public class func encryptPassowrd(password: String, session: String? = nil) -> String {
		if let session = session {
			return CJWDesEncrypt.encrypt(password, key: session)
		}
		return password.encryptPassword()
	}

}

extension QPSecurityUtils {

	public class func saveSession(session: String) {
		saveCache("session", value: session)
	}

	public class func getSession() -> String {
		let str: AnyObject! = getCache("session")
		if str != nil {
			return str as! String
		} else {
			log.warning("no session was found")
			return ""
		}
	}
}

extension QPSecurityUtils {
	class func saveCache(key: String, value: AnyObject) {
		QPCacheUtils.cache(value, forKey: key)
	}

	class func getCache(key: String) -> AnyObject? {
		return QPCacheUtils.getCacheBy(key)
	}
}

extension String {

	private func getSessionKey() -> String {
//		let str: AnyObject! = QPSecurityUtils.getCache("session")
//		if str != nil {
//			return str as! String
//		} else {
//			log.warning("no session was found")
//			return ""
//		}
		return QPSecurityUtils.getSession()
	}

	func encryptPassword() -> String {
		let session = getSessionKey()
		let pwd = CJWDesEncrypt.encrypt(self, key: session as String)
		return pwd
	}
}