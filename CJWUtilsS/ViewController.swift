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

class CJWoOBJ : NSObject {
	var title = "String666"
	var numb = 1238
	var sss : UIView?
}

class ViewController: UITableViewController {

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
			default: print("other type = \(value) \(key)")
			}

			switch value {
			case let i as Int: print("• integer = \(i) \(key)")
			case let s as String: print("• string = \(s) \(key)")
			default: print("• other type = \(value) \(key)")
			}

			if let i = value as? Int {
				print("•• integer = \(i)")
			}
		}
	}

	let webView = UIWebView()

	override func viewDidLoad() {
//        self.pushViewController(self, animated: false)
		super.viewDidLoad()

		let url = "http://www.cenjiawen.com/method/posd"
		var URL = NSURL(string: url)
		URL = URL?.URLByAppendingPathComponent("asdsd")
		let mutableURLRequest = NSMutableURLRequest(URL: URL!)
		print("asdasd \(URL)")
		let req = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["aasd": 123, "111": "ss"])

		print("req \(req) \(req.0.URLString)")

		QPHttpUtils.sharedInstance.newHttpRequest("http://www.cenjiawen.com/qian", param: ["ll": "xx"], expires: 25, success: { (response) -> () in
			print("++\(response["content"].stringValue) ")
			print("\(response) ")
		}) { () -> () in
			//
		}

		self.tableView.registerClass(CJWCell.self, forCellReuseIdentifier: "CJWCell")

		tableView.aspectRatio()

//		QPHttpUtils.sharedInstance.uploadFile("wewe", param: ["aaa": "vvv", "bbb": "ccc"], images: [UIImage()], names: [""])
		log.outputLogLevel = .Debug

//		let stringObject: String = "testing"
//		let stringArrayObject: [String] = ["one", "two"]
//		let viewObject = UIView()
//		let anyObject: Any = "testing"
//
//		let stringMirror = Mirror(reflecting: stringObject)
//		let stringArrayMirror = Mirror(reflecting: stringArrayObject)
//		let viewMirror = Mirror(reflecting: viewObject)
//		let anyMirror = Mirror(reflecting: anyObject)
//
//		anyMirror.subjectType

		if let aClass = NSClassFromString("CJWoOBJ") as? NSObject.Type {

			let anObject = aClass.init()

			rfObject(anObject)
		}

//		let ooo = CJWoOBJ()
//        rfObject(anObject)

//		http.newHttpRequest("http: // 115.29.141.172/qian/", param: nil, success: { (response) -> () in
//			print(response)
//		}) { () -> () in
//			//
//		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CJWCell") as! CJWCell
		cell.setup()
		cell.label.setNeedsUpdateConstraints()
		cell.label.updateConstraintsIfNeeded()
		return cell
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

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
	}

	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}

class CJWCell : QPBaseTableViewCell {
	let label = UILabel()
	let label2 = UILabel()

	override func setupViews(view: UIView) {
		view.addSubview(label)
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
		label2.trailing(view, predicate: "-30")
		label2.bottom(view, predicate: "-20")
	}
}
