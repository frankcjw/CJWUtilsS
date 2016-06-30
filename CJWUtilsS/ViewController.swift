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

//		tableView.aspectRatio()

//		QPHttpUtils.sharedInstance.uploadFile("wewe", param: ["aaa": "vvv", "bbb": "ccc"], images: [UIImage()], names: [""])
		log.outputLogLevel = .Debug

		log.debug("hello")
		log.info("fuck")

		showNetworkException()
		testing()

		let flag = getFlag()
		let str = flag ? "flag = true" : " flag = false"
	}

	func getFlag() -> Bool {
		return false
	}

	func jump() {
		let vc = SecondeViewController()
		self.pushViewController(vc)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 11
	}

	override func cellForRow(atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CJWCell") as! CJWCell
		cell.backgroundColor = UIColor.clearColor()
		return cell
	}

//	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//		cell.setup()
//		cell.label.setNeedsUpdateConstraints()
//		cell.label.updateConstraintsIfNeeded()
//		return cell
//	}

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

		print(offsetY)
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
