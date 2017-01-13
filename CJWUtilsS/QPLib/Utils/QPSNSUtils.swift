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
		let url = "http://qp.cenjiawen.com:9090/sns/user/login"
		let password = QPSecurityUtils.encryptRSA("hello", publicKey: "")
		let aes = "eeeee".encryptAES("IX07L2433M88JFLJ")!
		let param = ["mobile": "13631290232", "password": password, "aes": aes]
//        QPSecurityUtils.enae
		QPHttpUtils.sharedInstance.newHttpRequest(url, param: param, success: { (response) in
			log.debug("\(response)")
		}) {
			log.debug("fail")
		}
	}
}
