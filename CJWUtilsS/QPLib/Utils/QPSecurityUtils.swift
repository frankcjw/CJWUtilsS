//
//  QPSecurityUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 9/7/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import CryptoSwift
import SwiftyRSA

public class QPSecurityUtils: NSObject {

	public class func encryptRSA(text: String, publicKey: String) -> String {
		let bundle = NSBundle.mainBundle()
		let publicKeyPath = bundle.pathForResource("rsa_public_key2", ofType: "pem")!
		let publicKey = try? String(contentsOfFile: publicKeyPath, encoding: NSUTF8StringEncoding)
		let encryptedString = try! SwiftyRSA.encryptString(text, publicKeyPEM: publicKey!)
		return encryptedString

	}

	public class func decryptRSA(encryptedString: String, privateKey: String) -> String {
		let bundle = NSBundle.mainBundle()
		let privateKeyPath = bundle.pathForResource("rsa_private_key1", ofType: "pem")!
		let privateKey = try? String(contentsOfFile: privateKeyPath, encoding: NSUTF8StringEncoding)
		let plainText = try! SwiftyRSA.decryptString(encryptedString, privateKeyPEM: privateKey!)
		return plainText;
	}

	public class func enc(pwd: String) {
//        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000
		let timestamp = NSDate().timeIntervalSince1970 * 1000
		let time = Int(timestamp)
		print("timestamp: \(time)")
		if let en = pwd.encryptAES("Bar12345Bar12345") {
			print(en)
			let auth = "\(en)\(time)"
			print(auth)
			print(auth.md5())
		}
	}

	public class func generateAuthParam(param: [String: AnyObject]!, pushId: String = QPSecurityUtils.getPushId()) -> [String: AnyObject]! {

		var newParam = param
		if param == nil {
			newParam = [:]
//			log.warning("generateNewParam param nil")
		}
		if let session = getCache("session") as? String {
			if let uid = getUID() {
				if uid == "0" {
					log.warning("uid = 0")
				} else {
					let pushId = pushId ?? "ErrorPushId"
					if pushId == "ErrorPushId" {
						log.warning("ErrorPushId")
					}
					let str = "\(uid)-\(pushId)"
					log.info(str)
					let auth = CJWDesEncrypt.encrypt(str, key: session as String)
					newParam["auth"] = auth
//					log.info("auth \(auth)")
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

	public class func saveUID(uid: String) {
		saveCache("UID", value: uid)
	}

	public class func getUID() -> String? {
		if let uid = getCache("UID") as? String {
			return uid
		}
		return nil
	}

	public class func savePushId(uid: String) {
		saveCache("PushId", value: uid)
	}

	public class func getPushId() -> String {
		if let uid = getCache("PushId") as? String {
			return uid
		}
		log.error("push nil")
		return "QPSecurityUtilsDefaultPushId"
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
		return QPSecurityUtils.getSession()
	}

	func encryptPassword() -> String {
		let session = getSessionKey()
		let pwd = CJWDesEncrypt.encrypt(self, key: session as String)
		return pwd
	}

}

public extension QPHttpUtils {
	func generateAuthParam(param: [String: AnyObject]!, pushId: String = QPSecurityUtils.getPushId()) -> [String: AnyObject]! {
		return QPSecurityUtils.generateAuthParam(param, pushId: pushId)
	}
}

public extension String {
	public func encryptAES(key: String) -> String? {
		let iv = "RandomInitVector"
		let sss = self
		do {
			let aes = try AES(key: key, iv: iv) // aes128
			let ciphertext = try aes.encrypt(sss.utf8.map({ $0 }))
			if let en = ciphertext.toBase64() {
				return en
			}
		} catch {
		}
		return nil
	}

	public func decryptAES(key: String) -> String? {
		let iv = "RandomInitVector"
		do {
			let aes = try AES(key: key, iv: iv) // aes128
			return try self.decryptBase64ToString(aes)
		} catch {
		}
		return nil
	}
}