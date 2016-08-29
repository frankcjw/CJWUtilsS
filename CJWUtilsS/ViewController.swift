//
//  ViewController.swift
//  CJWUtilsS
//
//  Created by cen on 8/12/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreData
import ObjectiveC
import Alamofire
import WebViewJavascriptBridge
import Mirror
import FXBlurView
import SwiftyRSA
import CryptoSwift

class CJWoOBJ: NSObject {
	var title = "String666"
	var numb = 1238
	var sss: UIView?
}

struct Hello {
	var flag: Bool = true
	var name: String = "fuck you"
	var price: Int?
}

class ViewController: QPTableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	let webView = UIWebView()

	override func viewDidLoad() {

		log.remoteUrl = "http://192.168.1.223:9090"
		let st = Hello()
		let mirror = Mirror(st)

		mirror.names
		print(mirror.toDictionary)

		super.viewDidLoad()

		self.tableView.registerClass(CJWCell.self, forCellReuseIdentifier: "CJWCell")

//		QPHttpUtils.sharedInstance.uploadFile("wewe", param: ["aaa": "vvv", "bbb": "ccc"], images: [UIImage()], names: [""])
		log.outputLogLevel = .Debug

		testing()
		rsa()

	}

	func accc(sender: QPTopIconButtonPro) {
		print("accc")
	}

	func jump() {
		let vc = SecondeViewController()
		self.pushViewController(vc)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	override func cellForRow(atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = GS()
		cell.backgroundColor = UIColor.clearColor()
		return cell
	}

	var imgv = UIImageView()
	let bv = FXBlurView()
	var isBlur = false

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		imgv.frame = self.view.frame
		imgv.image("http://ww1.sinaimg.cn/mw690/9e9d7b23gw1f4eg71jjgqg205m0ak7ac.gif", placeholder: "testing")

		bv.frame = self.view.frame
		bv.dynamic = true
		bv.updateInterval = 1
		self.tableView.insertSubview(bv, atIndex: 0)

		self.tableView.setInsetsTop(300)
		self.tableView.insertSubview(imgv, atIndex: 0)
	}

	override func scrollViewDidScroll(scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		super.scrollViewDidScroll(scrollView)
		imgv.frame = CGRectMake(imgv.x, offsetY, imgv.width, imgv.height)
		bv.frame = CGRectMake(bv.x, offsetY, bv.width, bv.height)

		if offsetY > 0 {

			if offsetY < 100 {
				let percent = (offsetY - 0) / 100
				print(percent)
				bv.alpha = percent
			} else {
				bv.alpha = 1
			}
			bv.hidden = false
		} else {
			bv.hidden = true
		}
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

//        QPKeyChainUtils.sharedInstance.cache("aaaa", forKey: "cjw")
//        cacheToDisk("aaaa", forKey: "cjw")
		if let value = QPKeyChainUtils.sharedInstance.cacheBy("cjw") {
			print("value \(value)")
		}

		let wb = SecondeViewController()
		// wb.url = "http://www.cenjiawen.com/qian"let path = NSBundle.mainBundle().pathForResource("attention2", ofType: "html")!
		let path = NSBundle.mainBundle().pathForResource("ExampleApp", ofType: "html")!
		do {
			let html = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
//			wb.webView.loadHTMLString(html, baseURL: nil)
			wb.html = html
		}
		catch let error as NSError {
			fatalError(error.localizedDescription)
		}

//		self.presentViewController(wb, animated: true) { () -> Void in
//			//
//		}
		self.view.showHUDTemporary("sdsds")
	}

	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
	}

	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
//

	func testing() {
		let tagString = "啊实1打实,啊实2打实,啊实3打实"
		let tags = tagString.characters.split { $0 == "," }.map(String.init)
		for tag in tags {
			print(tag)
		}
	}

	func rsa() {
//		let rsa = SwiftyRSA()
		let bundle = NSBundle.mainBundle()
		let pubPath = bundle.pathForResource("rsa_public_key", ofType: "pem")!
		let pubString = try? String(contentsOfFile: pubPath, encoding: NSUTF8StringEncoding)

		let str = "Frank"
		let pemString = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDAuG5B006eaxeYsx+njeNNJvPc\nPqie9WodNyEUjicQEFjOdQKhVK2WkM4DuMqVl43s+I5bS28BTdSf4OiZaH6Xn93f\nZy3sbc/dKcamE66MONnsVrfVL/dXYRGM7XCPruLKpQnuzWHIZIaIiRAZ1mXGJ6ig\nhW84bWRLMPWPYC2JZQIDAQAB\n-----END PUBLIC KEY-----\n"
		let encryptedString = try! SwiftyRSA.encryptString(str, publicKeyPEM: pemString)

//		let priPath = bundle.pathForResource("rsa_private_key", ofType: "pem")!
//		let priString = try? String(contentsOfFile: priPath, encoding: NSUTF8StringEncoding)

//		let signatureString = try! SwiftyRSA.signString(str, privateKeyPEM: pemString)
//		print("signatureString\n\(signatureString)")

		var param: [String: AnyObject] = [:]
		param["key1"] = "Value1"
		param["key2"] = "Value2"
		param["abc"] = "abc"
		param["zzz"] = "fff"

		var urlParam = ""
		for (key, value) in Array(param).sort({ $0.0 < $1.0 }) {
			urlParam = urlParam + "\(key)=\(value)&"
		}
		let url = (urlParam as NSString).substringToIndex(urlParam.length() - 1)

		var sign = url.md5()
		sign.urlEncode()

		let secret_key = sign
//        SwiftyRSA.encr
		let param_key = try! SwiftyRSA.encryptString(url, publicKeyPEM: pemString)
//		print("\(secret_key)\n\(param_key)")
		let requestUrl = "secret_key=\(secret_key)&param_key=\(param_key)"
		print("\(requestUrl)")

//		for key in sortedKeys {
//		}
//		let urlParam = "key1=value1&key2=value2"

		let count = "MIICoTAbBgkqhkiG9w0BBQMwDgQIC2bS+trZgQQCAggABIICgHiNSce6u9Z4Lg3PJAwvyB4q/7K5Ik4oTy39c9fBKyXnacZ5Vq8gqKhbhc/yOhL80X34/F6vea2iEFH/Qdajky6b5jPvvHMioNc0kD86qcMAsIJXBtWFt9FpswdFP+u/4MacoTFYDEg5h0vNum8HRX4rOPtIgjSbRFdVr6qaw2JXODb2mYfB8LqAy56kvQx2z9rq+n0knsACJZSyCFouIPg343+uxsUdhzdpvtEgF9Jd5Zmz3Vg13LSW/2xIAS6Niw4mhFLSfDjbM5FofM/UEfKHYpY8hlphANgtzHv972ca0nmiwb01lrT9AngkdSNniDRmUUQLW9SbXrM9tlFq55lyKar2cxLdio2ERz2N0RzmkwqEmY+M+mQkWh1ZZA08rbsLiuyu59htTjX5+pte+O2mQ9DvBbxbvSMppWV4pMtsfECLtpseyUjnRKrmdiFpoq0W8FLat/F9SaYM4tqpoPv0EyUH+nydWKrzvZ+zjtVzKimZr/fMbblR35KA5n3vildqGvGwdkHmq4QHzeUl3fj404EKe11YEyUv1jWn2l+gn1GDKB7XacNRIjVPvsAQPGtSB1vF7TGhUoLIXu+7nxzWf5P/+4jRFreGh+Z6zfZy/Gt1vPw8aAsmBTxPSnX1nBBtZdRvGZFx0a/CFeQJnJ7YDLadL+JGOjhE+5qKiKhoEOLIwYLYF7tKKPdrqqo54KiOzcuczJLr8W1bi7/4LWsEkKySJ+zfC43dnkG6xXhYt801nHWzzE0UOPVwucmNS01FforPytoZuzFdvhqgdXLhMEaJ4sjSYAV+r2OC6lPz1IUUXqX4NGvg8HDaJmoi3ex5ViRcrf1+kBZhnunz3tw="

		let count2 = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCERFbQ1ETtXKZuDZWd0rz1koiC3GOVehyJKlWUZy95sVR4oDu7/q/MDWbUFY6gK+5ZuQkkUcAzv8vX8AgDE9X2SRswlJvnWc4mUH+gTFuXXRmpDr1TA/pL/PR+ETqi9hRztyv+fzwNh2G5dPtI/zBtM/8Lgiqc9hySzChDodcvPwIDAQAB"
		print("\(count.length()) \(count2.length())")
	}
}

//extension String {
//	func split(s: String) -> [String] {
//		if s.isEmpty {
//			var x: [String] = []
//			for y in self {
//				x.append(String(y))
//			}
//			return x
//		}
//		return self.componentsSeparatedByString(s)
//	}
//}

class CJWCell: QPBaseTableViewCell {
	let label = UILabel()
	let label2 = UILabel()

	var hello: String = "yes"
	func rfObject(ooo: AnyObject) {
		let mirror = Mirror(reflecting: ooo)

		defer {
			print("defer")
		}

		defer {
			print("defer111")
		}

		let className = mirror.subjectType
		print("\(className)")
		var dictionary = [String: Any]()
		for child in mirror.children {
			guard let key = child.label else { continue }
			let value: Any = child.value

			dictionary[key] = value

			switch value {
			case is Int: print("integer = \(value) \(key)")
			case is String: print("string = \(value) \(key)")
			case is UIView: print("• UIView = \(value) \(key)")
			default: print("other type = \(value) \(key)")
			}

			switch value {
			case let i as Int: print("• integer = \(i) \(key)")
			case let s as String: print("• string = \(s) \(key)")
			case let v as UIView: print("• UIView = \(v) \(key)")
			default: print("• other type = \(value) \(key)")
			}

			if let i = value as? Int {
				print("•• integer = \(i)")
			}
		}
	}

	override func setupViews(view: UIView) {
		view.addSubview(label)
		rfObject(self)
		label.text = ".php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/"
		label.backgroundColor = UIColor.yellowColor()
		label.numberOfLines = 0

		view.addSubview(label2)
		label2.backgroundColor = UIColor.lightGrayColor()
		label2.numberOfLines = 0
		label2.text = "CJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLib"
	}

	override func setupConstrains(view: UIView) {
		label.alignTop("20", leading: "20", bottom: "<=-20", trailing: "-20", toView: view)
//		label.alignLeading("30", trailing: "-30", toView: view)
//		label.alignTopEdgeWithView(view, predicate: "30")
//		label.heightConstrain(">=200")
		label2.constrainTopSpaceToView(label, predicate: "30")

		label2.leadingAlign(view, predicate: "0")
		label2.trailingAlign(view, predicate: "-30")
		label2.bottomAlign(view, predicate: "-20")
	}
}

class GS: QPGridTableViewCell {

	override func numberOfItem() -> Int {
		return 4
	}

	override func numberOfColumn() -> Int {
		return 1
	}

	func heightPredicateForView() -> String {
		return "100"
	}

	override func viewAt(index: Int) -> UIView {
//		let button = QPTopIconButtonPro()
//		button.superview?.backgroundColor = UIColor.yellowColor()
//		button.setImage(UIImage(named: "testing"), forState: UIControlState.Normal)
//		button.setTitle("不换\n行驶证", forState: UIControlState.Normal)
//		button.backgroundColor = UIColor.peterRiverColor()
//		return button
		let view = UIView()
		view.debug()
		return view
	}

}
