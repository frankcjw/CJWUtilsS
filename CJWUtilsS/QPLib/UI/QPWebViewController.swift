//
//  YGWebViewController.swift
//  YGProject
//
//  Created by Frank on 12/18/15.
//  Copyright © 2015 YG. All rights reserved.
//

import UIKit

/// 简易web controller
public class QPWebViewController: QPViewController, UIWebViewDelegate {

	public let webView = UIWebView()

	public var url: String? = ""
	public var html: String?

	public var isPresent = false

	public var isShowLeftButtons = true

	public var isLoadTitle = true

	public func agent() -> String {
		return ""
	}

	private func setupAgent() {
		let agentString = agent()
		let oldAgent = self.webView.stringByEvaluatingJavaScriptFromString("navigator.userAgent")
		if let newAgent = oldAgent?.stringByAppendingString(" \(agentString)") {
			let dict = ["UserAgent": newAgent]
			NSUserDefaults.standardUserDefaults().registerDefaults(dict)
		}
	}

	override public func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}

	public override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
	}

	override public func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(webView)
		setupAgent()
		webView.alignTop("0", leading: "0", bottom: "0", trailing: "0", toView: self.view)
		webView.delegate = self

		if !load(url) {

			loadHtml(html)
		}

		self.view.setNeedsUpdateConstraints()
		self.view.updateConstraintsIfNeeded()
	}

	/**
	 加载html字符
	 (self.webView.scalesPageToFit = true)

	 - parameter html: html字符
	 */
	public func loadHtml(html: String?) {
		self.webView.scalesPageToFit = true
		if let hhh = html {
			if hhh.valid() {
				self.html = html
				self.webView.loadHTMLString(hhh, baseURL: nil)
			}
		}
	}

	/**
	 加载url

	 - parameter url: 需要加载的url

	 - returns: 是否加载成功
	 */
	public func load(url: String?) -> Bool {
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

	public func webViewDidFinishLoad(webView: UIWebView) {
		if isLoadTitle {
			self.title = webView.stringByEvaluatingJavaScriptFromString("document.title")
		}
		if webView.canGoBack {
			showBackAndClose()
		} else {
			showClose()
		}
	}

	public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		return true
	}

	public func currentURL() -> String? {
		return (self.webView.request?.URLRequest.URL?.absoluteString)
	}

	func back() {
		self.webView.goBack()
	}

	func close() {
		if isPresent {
			self.dismiss()
		} else {
			self.popViewController()
		}
	}

	private func showClose() {

		if isShowLeftButtons {
			let closeButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(QPWebViewController.close))
			self.navigationItem.leftBarButtonItems = [closeButton]
		}

	}

	private func showBackAndClose() {

		if isShowLeftButtons {
			let btn = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(QPWebViewController.back))

			let closeButton = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(QPWebViewController.close))

			self.navigationItem.leftBarButtonItems = [btn, closeButton]
		}

	}

}