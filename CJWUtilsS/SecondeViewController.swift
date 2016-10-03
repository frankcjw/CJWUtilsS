//
//  SecondeViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 3/14/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import WebViewJavascriptBridge

class SecondeViewController: QPWebViewController {

	var bridge: WebViewJavascriptBridge!

	override func viewDidLoad() {
		super.viewDidLoad()
		WebViewJavascriptBridge.enableLogging()
		bridge = WebViewJavascriptBridge(forWebView: self.webView)
		bridge.registerHandler("testObjcCallback") { (data, responseCallback) -> Void in
			responseCallback("fuck you")
			self.showConfirmAlert("点击", message: "时间", confirm: { () -> () in
				//
			})
		}
		webView.bottomAlign(self.view)

		let label = UILabel(frame: CGRectMake(0, 0, 100, 100))
		label.text = "tio"
		label.backgroundColor = UIColor.alizarinColor()
		label.addTapGesture(self, action: #selector(SecondeViewController.jump))
		view.addSubview(label)
	}

	func jump() {
		self.popViewController()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */
}
