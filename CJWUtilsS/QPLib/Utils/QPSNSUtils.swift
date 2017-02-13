//
//  QPSNSUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 12/01/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

class QPSNSUtils: NSObject {

	class var sharedInstance: QPSNSUtils {
		struct Static {
			static var onceToken: dispatch_once_t = 0
			static var instance: QPSNSUtils? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPSNSUtils()
		}
		return Static.instance!
	}

	func register() {
		// http://app.cenajiwen.com/sns/user/register/
		let pwd = QPSecurityUtils.encryptRSA("hello", publicKey: "")
		QPHttpUtils.sharedInstance.newHttpRequest("http://qp.cenjiawen.com:9090/sns/user/register/", param: ["password": pwd, "mobile": "1234"], success: { (response) in
			log.debug("\(response)")
		}) {
			log.debug("fail")
		}
	}

	func login() {
		let aesKey = "IX07L2433M88JFLJ"
		let url = "http://qp.cenjiawen.com:9090/sns/user/login"
		let password = QPSecurityUtils.encryptRSA("qweasdzxc", publicKey: "")
		let token = "eeeee".encryptAES(aesKey)!
		let param = ["mobile": "13631290232", "password": password, "token": token]
//        QPSecurityUtils.enae
		QPHttpUtils.sharedInstance.newHttpRequest(url, param: param, success: { (response) in
			log.debug("\(response)")
			let info = response["info"].stringValue
//			let de = QPSecurityUtils.decryptRSA(info, privateKey: "")
			let de = info.decryptAES(aesKey)
			log.info("\(de)")
		}) {
			log.debug("fail")
		}
	}
}
