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
//import Mirror
import FXBlurView
import SwiftyRSA
import EventKit
import QRCodeReaderViewController
import SwiftyJSON
import GPUImage
import CGFloatType

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

	var data: [Int] = [1, 2, 3, 4, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6]
	var appendData: [Int] = [1, 2, 3, 4, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6]

	override func viewDidLoad() {
//		QPEventUtils.verifyUserAuthorization(EKEntityType.Event, success: {
//			let utils = QPEventUtils()
//			utils.addCalendatTitle("贵州商会活动", block: { (calendar) in
//				let start = NSDate()
//				let end = start.dateByAddingTimeInterval(300)
//				utils.addCalendar("测试活动", note: "是魔鬼", startDate: start, endDate: end, calendar: calendar)
//			})
//		}) {
//		}
//		let st = Hello()
//		let mirror = Mirror(st)
// 		mirror.names
//		print(mirror.toDictionary)

		super.viewDidLoad()

		self.tableView.registerClass(CJWCell.self, forCellReuseIdentifier: "CJWCell")
		self.tableView.registerClass(GridCell.self, forCellReuseIdentifier: "GridCell")
		self.tableView.registerClass(QPAdvTableViewCell.self, forCellReuseIdentifier: "QPAdvTableViewCell")
		self.tableView.registerClass(TTImageTableViewCell.self, forCellReuseIdentifier: "TTImageTableViewCell")
		self.tableView.registerClass(TTImageTableViewCell2.self, forCellReuseIdentifier: "TTImageTableViewCell2")

		testing()
		rsa()

		self.tableView.addRefreshFooter(self, action: #selector(UIViewController.requestMore))

		self.translucentBar(UIColor.peterRiverColor())

		self.title = "我"

		let imgt = UIImage(named: "testing")!
//		QPHttpUtils.sharedInstance.uploadThirdPartImage(imgt, success: { (response) in
//			print("\(response)")
//			let url = response["data"]["url"]
//			print("\(url)")
//		}) {
//			//
//		}

//		self.view.showLoading("提交中")
//		self.view.hideAllHUD()
//		self.popViewController()
//		self.showText("提交失败")

//		filterImage()

		QPSecurityUtils.enc("fuckyou")
//		newRsa()

//        showal

		standerRSA()
	}

	func standerRSA() {
//		let encryptedString = "WWRG1LaGEZl2Xjty9HB6fKIZUX8d7mNvTxIM36mzL/07HPTb5F4RFyXSuvHTTogKrqJMn7DUGClQ7/U5d6d1lTfbw8zMkINPENiiyon2IhQBvQwhvY0zfK6sjVCXnJRToi305ik/mz6fBti8ar568OvF/9H5k2ICVZRkPHMrfiA=";

//		QPSecurityUtils.decryptRSA("pk4IZhlAyqzJrvsIOscesx7ELzLXEQS27F7TPqnG03kgmgxnj7O6eV8ebz/edpL+Dm7bO95UafFCq4g9QwxGr+QaluyoQ9AkJgZWCepCFMMLBLEjOUrt9kDAARjVI+k3Q/V9DvtOdwminD4UipKYAXDzQOxP6S5eE9mwqVfieps=", privateKey: "")

		let encryptedString = QPSecurityUtils.encryptRSA("hello", publicKey: "")
		print("[\(encryptedString)]")
//		let de = QPSecurityUtils.decryptRSA(encryptedString, privateKey: "")
//		print("de: \(de)")
	}

	func filterImage() {
		let imageName = "gg.jpg"
		var img = UIImage(named: imageName)!
		let img2 = UIImage(named: "dog.jpg")!
		let img3 = UIImage(named: "ran.png")!

		let filter = GPUImageBrightnessFilter()

		let blur = GPUImageiOSBlurFilter()
//		blur.downsampling = 0.1
//		blur.blurRadiusInPixels = 0.5
		filter.brightness = -0.3
//		img = filter.imageByFilteringImage(img)
//		img = blur.imageByFilteringImage(img)

		let imgv = UIImageView(frame: CGRectMake(0, 100, 200, 200))
//		imgv.image = img
		imgv.scaleAspectFit()
		imgv.centerCropImage()
		imgv.dim(0.1)

		// color.
		self.view.addSubview(imgv)

		let imgv2 = UIImageView(frame: CGRectMake(0, 300, 200, 200))
		imgv2.image = UIImage(named: imageName)!
		imgv2.scaleAspectFit()
		self.view.addSubview(imgv2)

		let mask = GPUImageMaskFilter()
		mask.imageByFilteringImage(img2)

		let mk = GPUImagePicture(image: UIImage(named: "lady.jpeg")!)
		let pic = GPUImagePicture(image: img)

		pic.addTarget(mask)
//		pic.replaceTextureWithSubimage(img2)
		pic.processImage()
//		let nmg = pic.imageByFilteringImage(img2)
		let nmg = mask.imageByFilteringImage(img3)
		imgv.image = nmg
//
	}

	var sections: [JSON] = []

	override func requestMore() {

		self.data.appendContentsOf(self.appendData)
		self.tableView.endRefreshFooter()
		self.tableView.reloadData()
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
//		return data.count
		return 1
	}

	override func cellForRow(atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if indexPath.section == 1 {
//			let cell = tableView.dequeueReusableCellWithIdentifier("TTImageTableViewCell") as! TTImageTableViewCell
//			cell.debug(true)
//			return cell
		} else if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCellWithIdentifier("QPAdvTableViewCell") as! QPAdvTableViewCell
			cell.delegate = self
			cell.placeholderImage = "testing"
//			cell.updateAdv(["", "", ""])
			return cell
		}
//		let cell = tableView.dequeueReusableCellWithIdentifier("GS") as! GS

		let cell = tableView.dequeueReusableCellWithIdentifier("GridCell") as! GridCell
//        drawcell
//		cell.drawGrids(30)
		cell.backgroundColor = UIColor.clearColor()
		return cell
	}

	let cellHeight: CGFloat = (CGFloat(27) / CGFloat(100)) * SCREEN_WIDTH

//	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//		return cellHeight
//	}
//
//	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//		return cellHeight
//	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		super.tableView(tableView, didSelectRowAtIndexPath: indexPath)

		self.pickImage(1, block: { (images) in
			let img = images[0]
			let imgv = UIImageView(frame: CGRectMake(0, 100, 100, 100))
			self.view.addSubview(imgv)
			imgv.image = img
		})
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
//		let vc = QPExamTableViewController()
//		self.pushViewController(vc)
//		self.tableView.setInsetsTop(300)

		let imgv = QPTImageView(frame: CGRectMake(100, 100, 100, 100))
		imgv.backgroundColor = UIColor.redColor()
		self.view.addSubview(imgv)

		for bd in NSBundle.allBundles() {
			print("\(bd.bundleIdentifier)")
		}

		if QPFeatureViewController.canShowNewFeature() {
			let vc = QPFeatureViewController()
			vc.images = ["dog.jpg", "gg.jpg", "lady.jpeg"]
			vc.setOnEndNewFeatureBlock({
				vc.popViewController()
			})
			self.pushViewController(vc)
		}
//		let bundle = NSBundle(identifier: "com.cenjiawen.app.CJWUtilsS")
//		print("bundle \(bundle)")
//		let img = UIImage(named: "Expression_1@2x.png", inBundle: bundle, compatibleWithTraitCollection: nil)
//		imgv.image = img

	}

	override func scrollViewDidScroll(scrollView: UIScrollView) {
		super.scrollViewDidScroll(scrollView)
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

		// text.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(integer:(NSUnderlineStyle.StyleDouble).toRaw()), range: NSMakeRange(0, text.length))

//		let qrv = QRCodeReaderView(frame: CGRectMake(100, 100, 100, 100))
//		self.view.addSubview(qrv)
//		let reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
//		let vc = QRCodeReaderViewController(cancelButtonTitle: "cancel", codeReader: reader, startScanningAtLoad: true, showSwitchCameraButton: true, showTorchButton: true)
////		self.pushViewController(vc)
//		reader.setCompletionWithBlock { (str) in
//			print("\(str)")
//		}

//		excute(3) {
//			let vc = QPFormTableViewController()
//			self.pushViewController(vc)
//		}

	}

	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}

	func testing() {
		let tagString = "啊实1打实,啊实2打实,啊实3打实"
		let tags = tagString.characters.split { $0 == "," }.map(String.init)

	}

	func newRsa() {

		let bundle = NSBundle.mainBundle()
		let pubPath = bundle.pathForResource("rsa_public_key", ofType: "pem")!
		let pubPathJava = bundle.pathForResource("rsa_public_key_java", ofType: "pem")!
		let pubPathPrivate = bundle.pathForResource("rsa_private_key", ofType: "pem")!
		let pubPathPrivateJava = bundle.pathForResource("rsa_private_key_java", ofType: "pem")!

		let str = "Frank"
		let pemString = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDAuG5B006eaxeYsx+njeNNJvPc\nPqie9WodNyEUjicQEFjOdQKhVK2WkM4DuMqVl43s+I5bS28BTdSf4OiZaH6Xn93f\nZy3sbc/dKcamE66MONnsVrfVL/dXYRGM7XCPruLKpQnuzWHIZIaIiRAZ1mXGJ6ig\nhW84bWRLMPWPYC2JZQIDAQAB\n-----END PUBLIC KEY-----\n"

		let publicKey = try? String(contentsOfFile: pubPath, encoding: NSUTF8StringEncoding)
		let privateKey = try? String(contentsOfFile: pubPathPrivate, encoding: NSUTF8StringEncoding)
		print("\(publicKey!)")
		print("--\n\(privateKey!)\n--")
		print("\(pemString)")

		let encryptedString = try! SwiftyRSA.encryptString(str, publicKeyPEM: publicKey!)
		print(encryptedString)
		print("fff")
		print(privateKey)
		let sss = try! SwiftyRSA.decryptString(encryptedString, privateKeyPEM: privateKey!)
		print(sss)
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

class GridCell: QPTableViewCell {
	let grid = QPGridView(count: 4, column: 2)
//	let grid = QPGridView()

	override func setupViews(view: UIView) {
		super.setupViews(view)

//		grid.text = "asd\nasd\nasd\nasd\nasd\n"
//		grid.numberOfLines = 0
		view.addSubview(grid)
	}

	override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		grid.centerX(view)
//        grid.width(view, predicate: "0.75")
//		grid.leadingAlign(view, predicate: "0")
		grid.debug()
//		grid.trailingAlign(view, predicate: "0")
		grid.topAlign(view, predicate: "0")
		grid.bottomAlign(view, predicate: "0")
		grid.widthConstrain("250")
//		grid.heightConstrain("200")

	}
}

class TTImageTableViewCell2: TTImageTableViewCell {
	override func setupViews(view: UIView) {
		super.setupViews(view)
		let frame = CGRectMake(0, 0, 100, 100)
		locationImage.frame = frame
		titleLabel.frame = frame
		distanceLabel.frame = frame
		infoLabel.frame = frame
//		backgroundImageView.frame = frame
		blackView.frame = frame
	}

	override func setupConstrains(view: UIView) {
	}
}
class TTImageTableViewCell: QPTableViewCell {
//	let img = UIImageView()
//	let label = UILabel()

	let locationImage = UIImageView()
	let titleLabel = UILabel()
	let distanceLabel = UILabel()
	let infoLabel = UILabel()
	let backgroundImageView = UIImageView()

	let blackView = UIView()

	override func setupViews(view: UIView) {
		super.setupViews(view)
//		view.addSubview(img)
//		img.imageWithSize(1000, height: 1000)

		view.addSubview(backgroundImageView)
		view.addSubview(blackView)
		view.addSubview(locationImage)
		view.addSubview(titleLabel)
		view.addSubview(distanceLabel)
		view.addSubview(infoLabel)
		view.backgroundColorBlack()

		backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
		backgroundImageView.clipsToBounds = true
		titleLabel.textColor = UIColor.whiteColor()
		distanceLabel.textColor = UIColor.whiteColor()
		infoLabel.textColor = UIColor.whiteColor()
		blackView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
		blackView.hidden = true
		view.debug(true)

	}

	override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		blackView.equalConstrain()

		backgroundImageView.leadingAlign(view, predicate: "0")
		backgroundImageView.trailingAlign(view, predicate: "0")
		backgroundImageView.topAlign(view, predicate: "0")
		backgroundImageView.bottomAlign(view, predicate: "-1")

		let fff: CGFloat = CGFloat(100) / CGFloat(27)
		backgroundImageView.aspectRatio("*\(fff)")

		locationImage.topAlign(backgroundImageView, predicate: "16")
		locationImage.centerX(backgroundImageView)
		locationImage.heightConstrain("15")
		locationImage.aspectRatio()

		distanceLabel.topConstrain(locationImage, predicate: "5")
		distanceLabel.centerX(locationImage)

		titleLabel.centerX(locationImage)
		titleLabel.topConstrain(distanceLabel, predicate: "5")
		infoLabel.centerX(locationImage)
		infoLabel.topConstrain(titleLabel, predicate: "8")
		infoLabel.bottomAlign(view, predicate: "-8")
	}
}

class GS: QPGridTableViewCell {

	override func numberOfItem(cell: QPTableViewCell) -> Int {
		return 10
	}

	override func numberOfColumn(cell: QPTableViewCell) -> Int {
		return 4
	}

	func heightPredicateForView(cell: QPTableViewCell) -> String {
		return "100"
	}

	override func viewAt(cell: QPTableViewCell, index: Int) -> UIView {
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

extension ViewController: QPInnerScrollViewCellDelegate {
	func innerScrollViewViewAt(cell: QPTableViewCell, index: Int) -> UIView {
		let view = UIImageView()
		view.backgroundColor = UIColor.redColor()
		view.debug()
		return view
	}

	func innerScrollViewNumberOfItem(cell: QPTableViewCell) -> Int {
		return 20
	}
}

extension ViewController: QPAdvTableViewCellDelegate {
	func numberOfItems(cell: QPTableViewCell) -> Int {
		return 3
	}

	func imageAtIndex(cell: QPTableViewCell, index: Int) -> String {
		let urls = ["http://wx4.sinaimg.cn/mw690/699d71c9ly1fbnov2nu0jj21ac0u0e58.jpg", "http://wx3.sinaimg.cn/mw690/699d71c9ly1fbnov1djqwj219n0u0tnc.jpg", "http://wx4.sinaimg.cn/mw690/699d71c9ly1fbnov0mafxj21ec0u0wsg.jpg"]
		return urls[index]
	}

	func didSelectAtIndex(cell: QPTableViewCell, index: Int) {
		print("click")
		QPSNSUtils.sharedInstance.login()
	}
}