//
//  YGWebViewController.swift
//  YGProject
//
//  Created by Frank on 12/18/15.
//  Copyright © 2015 YG. All rights reserved.
//

import UIKit

public class QPWebViewController: QPViewController {

	public let webView = UIWebView()
	public var url : String? = ""

	override public func viewDidLoad() {
		super.viewDidLoad()
//		webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
		webView.alignTop("0", leading: "0", bottom: "0", trailing: "0", toView: self.view)
		self.view.addSubview(webView)
		load(url)
		self.view.setNeedsUpdateConstraints()
		self.view.updateConstraintsIfNeeded()
	}

	public func load(url : String?) -> Bool {
		if url != nil && url != "" {
			self.url = url!
			if let nsurl = NSURL(string: url!) {
				let request = NSURLRequest(URL: nsurl)
				webView.loadRequest(request)
				return true
			} else {
			}
		}
		return false
	}
}