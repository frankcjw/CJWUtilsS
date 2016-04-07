//
//  QPBaseViewController.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

public typealias QPViewController = QPBaseViewController

public class QPBaseViewController: UIViewController {

	public var info = NSDictionary()
	override public func viewDidLoad() {
		super.viewDidLoad()
	}

	/// 是否隐藏NavigationBar,默认不隐藏
	public var shouldHideNavigationBar: Bool = false

	override public func viewWillAppear(animated: Bool) {

		if shouldHideNavigationBar {

			self.navigationController?.setNavigationBarHidden(true, animated: animated)
		} else {

//            self.navigationController?.navigationBar.translucentWith(UIColor.whiteColor())
			self.navigationController?.navigationBar.translucent = false

			self.navigationController?.setNavigationBarHidden(false, animated: animated)
//            self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
		}
		super.viewWillAppear(animated)
	}

	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

public extension UIViewController {
	/**
	 请求服务器方法.
	 */
	public func request() {
	}

	/**
	 请求加载更多
	 */
	public func requestMore() {
	}
}

public extension UIViewController {
	/**
	 安全的push view controller

	 - parameter viewController: 要跳转的view controller
	 - parameter animated:       是否动画 默认true
	 */
	public func pushViewController(viewController: UIViewController, animated: Bool = true) {
		if let navi = self.navigationController {
			viewController.hidesBottomBarWhenPushed = true
			navi.pushViewController(viewController, animated: animated)
		}
	}

	/**
	 安全的返回上一页

	 - parameter animated: 是否动画 默认true
	 */
	public func popViewController(animated: Bool = true) {
		if let navi = self.navigationController {
			navi.popViewControllerAnimated(animated)
		}
	}

	public func setBackTitle(title: String) {
		let button = UIButton(frame: CGRectMake(0, 0, 30, 30))
		button.setBackgroundImage(UIImage(named: "Practicetopic_icon_back"), forState: .Normal)
		button.addTarget(self, action: "controllerDismiss", forControlEvents: UIControlEvents.TouchUpInside)
		let back = UIBarButtonItem()
		// back.title = title
		back.customView = button
		// self.navigationItem.backBarButtonItem = back
		// self.navigationItem.leftBarButtonItem = back
	}

	public func setBackAction(action: Selector) {
		let back = UIBarButtonItem()
		// back.title = title
		back.action = action
		self.navigationItem.backBarButtonItem = back
	}

	public func showNetworkException() {
		let text = "网络错误"
		if view is UITableView {
			self.navigationController?.view.showHUDTemporary(text)
		} else {
			self.view.showHUDTemporary(text)
		}
	}
}

extension UIViewController {
	func newViewWillAppear(animated: Bool) {
//        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
		// IQKeyboardManager.sharedManager().enableAutoToolbar = false
//        IQKeyboardManager.sharedManager().preventShowingBottomBlankSpace = true
		// self.navigationController?.interactivePopGestureRecognizer?.delegate = self
		self.navigationItem.backBarButtonItem?.enabled = false
	}

	func newViewWillDisappear(animated: Bool) {
		self.view.endEditing(true)
		self.navigationController?.view.endEditing(true)
	}
}

public extension UIView {
	/**
	 把view以及子view的translatesAutoresizingMaskIntoConstraints = false
	 */
	public func setToAutoLayout() {
		if self.subviews.count > 0 {
			for sv in self.subviews {
				sv.setToAutoLayout()
			}
		}
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
